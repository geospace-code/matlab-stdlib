// C++ Matlab MEX function using C++17 <filesystem>
// build examples:
// * MSVC: mex COMPFLAGS="/EHsc /std:c++17" is_char_device.cpp
// * GCC: mex CXXFLAGS="-std=c++17" is_char_device.cpp

// https://www.mathworks.com/help/matlab/matlab_external/data-types-for-passing-mex-function-data-1.html

#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>
// note: <string_view> causes compile failures with MSVC at least

#include <vector>
#include <memory>

#if defined(_MSC_VER)
# define WIN32_LEAN_AND_MEAN
# include <windows.h>
#elif __has_include(<filesystem>)
# include <filesystem>
# include <system_error>
#endif

#include <sys/types.h>
#include <sys/stat.h>

static int fs_st_mode(std::string path)
{
// https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/stat-functions
  struct stat s;

  return stat(path.data(), &s) == 0 ? s.st_mode : 0;
}


static bool fs_is_char_device(std::string path)
{
// character device like /dev/null or CONIN$
#if defined(_MSC_VER)
  // currently broken in MSVC STL for <filesystem>
  HANDLE h =
    CreateFileA(path.data(), GENERIC_READ, FILE_SHARE_READ,
                nullptr, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, nullptr);
  if (h == INVALID_HANDLE_VALUE)
    return false;

  const DWORD type = GetFileType(h);
  CloseHandle(h);
  return type == FILE_TYPE_CHAR;
#elif defined(__cpp_lib_filesystem)
  std::error_code ec;
  return std::filesystem::is_character_file(path, ec) && !ec;
#else
  // Windows: https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/fstat-fstat32-fstat64-fstati64-fstat32i64-fstat64i32
  return S_ISCHR(fs_st_mode(path));
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
    bool y = fs_is_char_device(inputStr);

// convert to Matlab output -- even scalars are arrays in Matlab
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] =  factory.createArray<bool>({1,1}, {y});
  }
};
