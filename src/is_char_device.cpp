#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>
#include <string_view>

#include <vector>
#include <memory>

#if defined(_MSC_VER)
# define WIN32_LEAN_AND_MEAN
# include <windows.h>
#else
# include <filesystem>
# include <system_error>
#endif


static bool fs_is_char_device(std::string_view path)
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
#else
  std::error_code ec;
  return std::filesystem::is_character_file(path, ec) && !ec;
#endif
}


class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabEng = getEngine();

    matlab::data::ArrayFactory factory;
// wrangle inputs
    std::string in;

    if (inputs.size() != 1) {
      matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: One input required") }));
    }
    if ((inputs[0].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[0].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[0];
        in = stringArr[0];
    } else if (inputs[0].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[0];
        in.assign(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: First input must be a scalar string or char vector") }));
    }

// actual function algorithm / computation
    bool y = fs_is_char_device(in);

// convert to Matlab output
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar<bool>(y);

  }
};
