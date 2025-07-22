%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function f = disk_available(d)
arguments
  d {mustBeTextScalar}
end

f = uint64(0);
if ~stdlib.exists(d), return, end

if stdlib.has_python()
  di = py.shutil.disk_usage(d);
  f = uint64(int64(di.free)); % int64 first is for Matlab <= R2022a
elseif stdlib.has_dotnet()
  f = System.IO.DriveInfo(stdlib.absolute(d)).AvailableFreeSpace();
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.driveinfo.availablefreespace
elseif stdlib.has_java()
  f = javaObject("java.io.File", d).getUsableSpace();
  f = uint64(f);
end

%!assert (disk_available('.') > 0)
