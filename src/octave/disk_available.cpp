#include <octave/oct.h>

#include <string>

#include <filesystem>


DEFUN_DLD (disk_available, args, nargout,
           "disk space available to user")
{
  if (args.length() != 1){
    octave_stdout << "Oct: One input required\n";
    return octave_value(0);
  }

  std::uintmax_t s = std::filesystem::space(args(0).string_value()).available;

  return octave_value(s);
}
