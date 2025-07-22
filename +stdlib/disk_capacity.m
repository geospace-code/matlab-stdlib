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
  di = py.shutil.disk_usage(d);
  f = uint64(int64(di.total)); % int64 first is for Matlab <= R2022a
elseif stdlib.has_dotnet()
  f = System.IO.DriveInfo(stdlib.absolute(d)).TotalSize();
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.totalsize
elseif stdlib.has_java()
  f = javaObject("java.io.File", d).getTotalSpace();
  f = uint64(f);
end

end

%!assert (disk_capacity('.') > 0)
