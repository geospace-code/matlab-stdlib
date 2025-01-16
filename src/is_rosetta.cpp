#include "mex.hpp"
#include "mexAdapter.hpp"

#include <vector>
#include <memory>

#include "macos_fs.h"


class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

    matlab::data::ArrayFactory factory;
// boilerplate input checks
    if (inputs.size() != 0) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("No input required") }));
    }

// actual function algorithm / computation
    bool y = fs_is_rosetta();

// convert to Matlab output
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar<bool>(y);
  }
};
