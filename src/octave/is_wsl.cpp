#include <octave/oct.h>

#include "linux_fs.cpp"


DEFUN_DLD (is_wsl, args, nargout,
           "is Octave running under WSL")
{
  if (args.length() != 0){
    octave_stdout << "Oct: No input required\n";
    return octave_value(-1);
  }

  int wsl = fs_is_wsl();

  return octave_value(wsl);
}
