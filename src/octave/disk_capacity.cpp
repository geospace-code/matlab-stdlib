#include <octave/oct.h>

#include <cstdint>
#include <filesystem>


DEFUN_DLD (disk_capacity, args, nargout,
           "disk space capacity to user")
{
  if (args.length() != 1){
    octave_stdout << "Oct: One input required\n";
    return octave_value(0);
  }

  std::uintmax_t s = std::filesystem::space(args(0).string_value()).capacity;

  return octave_value(s);
}
