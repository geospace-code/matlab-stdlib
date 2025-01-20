#include <octave/oct.h>

#include <string>
#include <filesystem>


DEFUN_DLD (unlink, args, nargout,
           "delete file or empty directory")
{
  if (args.length() != 1){
    octave_stdout << "Oct: One input required\n";
    return octave_value(false);
  }

  std::error_code ec;
  bool y = std::filesystem::remove(args(0).string_value(), ec) && !ec;

  return octave_value(y);
}
