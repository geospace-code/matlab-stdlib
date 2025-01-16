#include <octave/oct.h>

#include "admin_fs.cpp"


DEFUN_DLD (is_admin, args, nargout,
           "is the process running as admin / root / superuser")
{
  if (args.length() != 0){
    octave_stdout << "Oct: No input required\n";
    return octave_value(false);
  }

  bool y = fs_is_admin();

  return octave_value(y);
}
