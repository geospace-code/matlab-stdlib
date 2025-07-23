%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(d)
arguments
  d {mustBeTextScalar}
end

f = uint64(0);
if ~stdlib.exists(d), return, end

if stdlib.has_python()
  f = py_disk_capacity(d);
elseif stdlib.has_dotnet()
  f = System.IO.DriveInfo(stdlib.absolute(d)).TotalSize();
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize
elseif stdlib.has_java()
  f = javaObject("java.io.File", d).getTotalSpace();
end

f = uint64(f);

end

%!assert (disk_capacity('.') > 0)
