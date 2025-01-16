#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>
// note: <string_view> causes compile failures with MSVC at least

#include <vector>
#include <memory>

#if defined(_WIN32)
# define WIN32_LEAN_AND_MEAN
# include <windows.h>
#else
# include <unistd.h> // for symlink()
#endif

#if __has_include(<filesystem>)
# include <filesystem>
# include <system_error>
#endif


bool fs_create_symlink(std::string target, std::string link)
{
  // confusing program errors if target is "" -- we'd never make such a symlink in real use.
  if(target.empty())
    return false;

  // macOS needs empty check to avoid SIGABRT
  if(link.empty())
    return false;

#if defined(__MINGW32__) || (defined(_WIN32) && !defined(__cpp_lib_filesystem))

  const DWORD attr = GetFileAttributesA(target.data());
// https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfileattributesa
// https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants

  if (attr == INVALID_FILE_ATTRIBUTES)
    return false;

  DWORD p = SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE;
  if(attr & FILE_ATTRIBUTE_DIRECTORY)
    p |= SYMBOLIC_LINK_FLAG_DIRECTORY;

  return CreateSymbolicLinkA(link.data(), target.data(), p);
#elif defined(__cpp_lib_filesystem)
  std::error_code ec;
  std::filesystem::path t(target);

  bool isdir = std::filesystem::is_directory(t, ec);
  if (ec)
    return false;

  isdir
    ? std::filesystem::create_directory_symlink(t, link, ec)
    : std::filesystem::create_symlink(t, link, ec);

  return !ec;
#else
  // https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/symlink.2.html
  // https://linux.die.net/man/3/symlink
  return symlink(target.data(), link.data()) == 0;
#endif

}


class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabEng = getEngine();

    matlab::data::ArrayFactory factory;
// wrangle inputs
    std::string target, link;

    if (inputs.size() != 2) {
      matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Two inputs required") }));
    }

    if ((inputs[0].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[0].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[0];
        target = stringArr[0];
    } else if (inputs[0].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[0];
        target.assign(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: First input must be a scalar string or char vector") }));
    }

     if ((inputs[1].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[1].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[1];
        link = stringArr[0];
    } else if (inputs[1].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[1];
        link.assign(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: Second input must be a scalar string or char vector") }));
    }

// actual function algorithm / computation
    bool y = fs_create_symlink(target, link);

// convert to Matlab output
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar<bool>(y);
  }
};
