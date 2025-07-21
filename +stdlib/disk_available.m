%% DISK_AVAILABLE disk available space (bytes)
% optional: mex
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

if stdlib.has_dotnet()
  f = System.IO.DriveInfo(stdlib.absolute(d)).AvailableFreeSpace();
elseif stdlib.has_java()
  f = javaObject("java.io.File", d).getUsableSpace();
  f = uint64(f);
end

%!assert (disk_available('.') > 0)
