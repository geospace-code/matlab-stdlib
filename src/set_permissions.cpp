// C++ Matlab MEX function using C++17 <filesystem>
// https://www.mathworks.com/help/matlab/matlab_external/data-types-for-passing-mex-function-data-1.html

#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>
// note: <string_view> causes compile failures with MSVC at least

#include <vector>
#include <memory>

#if __has_include(<filesystem>)
# include <filesystem>
# include <system_error>
#endif


static bool fs_set_permissions(std::string path, int readable, int writable, int executable)
{
#ifdef __cpp_lib_filesystem

#if defined(__cpp_using_enum)  // C++20
  using enum std::filesystem::perms;
#else
  constexpr std::filesystem::perms owner_read = std::filesystem::perms::owner_read;
  constexpr std::filesystem::perms owner_write = std::filesystem::perms::owner_write;
  constexpr std::filesystem::perms owner_exec = std::filesystem::perms::owner_exec;
#endif

  std::filesystem::path p(path);
  std::error_code ec;
  // need to error if path doesn't exist and no operations are requested
  if(!std::filesystem::exists(p))
    ec = std::make_error_code(std::errc::no_such_file_or_directory);

  if (!ec && readable != 0)
    std::filesystem::permissions(p, owner_read,
      (readable > 0) ? std::filesystem::perm_options::add : std::filesystem::perm_options::remove,
      ec);

  if (!ec && writable != 0)
    std::filesystem::permissions(p, owner_write,
      (writable > 0) ? std::filesystem::perm_options::add : std::filesystem::perm_options::remove,
      ec);

  if (!ec && executable != 0)
    std::filesystem::permissions(p, owner_exec,
      (executable > 0) ? std::filesystem::perm_options::add : std::filesystem::perm_options::remove,
      ec);

  if(!ec)
    return true;

#endif
  return false;

}



class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

    matlab::data::ArrayFactory factory;
// boilerplate input checks
    if (inputs.size() != 4) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Four inputs required") }));
    }
    if (inputs[0].getType() != matlab::data::ArrayType::MATLAB_STRING) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Input must be a string") }));
    }
    if (inputs[0].getNumberOfElements() != 1) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Input must be a scalar string") }));
    }
    if (inputs[1].getType() != matlab::data::ArrayType::DOUBLE ||
        inputs[2].getType() != matlab::data::ArrayType::DOUBLE ||
        inputs[3].getType() != matlab::data::ArrayType::DOUBLE) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Permission inputs must be doubles") }));
    }

// Matlab strings are an array, so we use [0][0] to get the first element
    std::string inputStr = inputs[0][0];

// actual function algorithm / computation
    bool y = fs_set_permissions(inputStr, inputs[1][0], inputs[2][0], inputs[3][0]);

// convert to Matlab output
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar<bool>(y);
  }
};
