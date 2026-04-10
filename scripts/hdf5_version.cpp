% build from GNU Octave with:
%
%   mkoctfile('hdf5_version.cpp', __octave_config_info__("HDF5_CPPFLAGS"), __octave_config_info__("HDF5_LDFLAGS"), __octave_config_info__("HDF5_LIBS"))
%
% then from GNU octave:
%
%   [maj, min, rel] = hdf5_version()
%

#include <octave/oct.h>
#include <hdf5.h>

DEFUN_DLD (hdf5_version, args, nargout,
           "Return HDF5 library version as [major, minor, release]")
{
  unsigned maj = 0, min = 0, rel = 0;
  herr_t status = H5get_libversion(&maj, &min, &rel);

  if (status < 0)
    error("H5get_libversion() failed");

  octave_value_list retval;
  retval(0) = octave_value(maj);
  retval(1) = octave_value(min);
  retval(2) = octave_value(rel);

  return retval;
}
