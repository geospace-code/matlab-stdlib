#include <octave/oct.h>

#include "macos.cpp"


DEFUN_DLD (is_rosetta, args, nargout,
           "is the process running under macOS Rosetta")
{
  if (args.length() != 0){
    octave_stdout << "is_rosetta: No input required\n";
    return octave_value(false);
  }

  bool y = fs_is_rosetta();

  return octave_value(y);
}
