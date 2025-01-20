#include <octave/oct.h>

#include <string>

#include "pure.cpp"
#include "normalize_fs.cpp"


DEFUN_DLD (normalize, args, nargout,
           "normalize path")
{
  if (args.length() != 1){
    octave_stdout << "Oct: One input required\n";
    return octave_value("");
  }

  std::string out = fs_normalize(args(0).string_value());

  return octave_value(out);
}
