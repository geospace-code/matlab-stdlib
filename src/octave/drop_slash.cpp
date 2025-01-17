#include <octave/oct.h>

#include <string>

#include "os.cpp"
#include "normalize.cpp"


DEFUN_DLD (drop_slash, args, nargout,
           "drop repeated and trailing slashes from a string")
{
  if (args.length() != 1){
    octave_stdout << "Oct: One input required\n";
    return octave_value("");
  }

  std::string out = fs_drop_slash(args(0).string_value());

  return octave_value(out);
}
