// C++ Matlab MEX function using C++17 <filesystem>
// https://www.mathworks.com/help/matlab/matlab_external/data-types-for-passing-mex-function-data-1.html

#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>
// note: <string_view> causes compile failures with MSVC at least

#include <vector>
#include <memory>

#if defined(_WIN32)
#include "win32_fs.h"
#endif


class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

    matlab::data::ArrayFactory factory;
// boilerplate input checks
    if (inputs.size() != 1) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("One input required") }));
    }
    if (inputs[0].getType() != matlab::data::ArrayType::MATLAB_STRING) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Input must be a string") }));
    }
    if (inputs[0].getNumberOfElements() != 1) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Input must be a scalar string") }));
    }

// Matlab strings are an array, so we use [0][0] to get the first element
    std::string inputStr = inputs[0][0];

// actual function algorithm / computation
#if defined(_WIN32)
    std::string s = fs_shortname(inputStr);
#else
    std::string s = "";
#endif

// convert to Matlab output -- even scalars are arrays in Matlab
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar(s);
  }
};
