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

if stdlib.has_dotnet()
  f = System.IO.DriveInfo(stdlib.absolute(d)).TotalSize();
elseif stdlib.has_java()
  f = javaObject("java.io.File", d).getTotalSpace();
  f = uint64(f);
end

end

%!assert (disk_capacity('.') > 0)
