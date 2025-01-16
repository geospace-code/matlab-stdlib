// C++ Matlab MEX function using C++17 <filesystem>
// https://www.mathworks.com/help/matlab/matlab_external/data-types-for-passing-mex-function-data-1.html

#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>
// note: <string_view> causes compile failures with MSVC at least

#include <vector>
#include <memory>

#if defined(_WIN32)
# include "win32_fs.h"
#endif

#if __has_include(<filesystem>)
# include <filesystem>
# include <system_error>
#endif

#include <sys/types.h>
#include <sys/stat.h>


static bool fs_is_symlink(std::string path)
{

#if defined(__MINGW32__) || (defined(_WIN32) && !defined(__cpp_lib_filesystem))
  return fs_win32_is_symlink(path);
#elif defined(__cpp_lib_filesystem)
// std::filesystem::symlink_status doesn't detect symlinks on MinGW
  std::error_code ec;
  const auto s = std::filesystem::symlink_status(path, ec);
  return !ec && std::filesystem::is_symlink(s);
#else
  struct stat s;
  return lstat(path.data(), &s) == 0 && S_ISLNK(s.st_mode);
#endif
}


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
    if (inputs[0].getType() != matlab::data::ArrayType::MATLAB_STRING ||
        inputs[0].getNumberOfElements() != 1) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Input must be a scalar string") }));
    }

// Matlab strings are an array, so we use [0][0] to get the first element
    std::string inputStr = inputs[0][0];

// actual function algorithm / computation
    bool y = fs_is_symlink(inputStr);

// convert to Matlab output
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar<bool>(y);
  }
};
