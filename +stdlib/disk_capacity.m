%% DISK_CAPACITY disk total capacity (bytes)
% optional: mex
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(d)
arguments
  d {mustBeTextScalar}
end

f = uint64(0);
if ~stdlib.exists(d), return, end

if NET.isNETSupported
  f = System.IO.DriveInfo(stdlib.absolute(d)).TotalSize();
else
  f = javaMethod("getTotalSpace", "java.io.File", d);
  f = uint64(f);
end

end

%!assert (disk_capacity('.') > 0)
