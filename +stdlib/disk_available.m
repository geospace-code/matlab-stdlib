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

if stdlib.has_dotnet()
  f = stdlib.dotnet.disk_available(d);
elseif stdlib.has_java()
  f = stdlib.java.disk_available(d);
elseif stdlib.has_python()
  f = stdlib.python.disk_available(d);
end

if f == 0
  f = stdlib.sys.disk_available(d);
end

f = uint64(f);

end

%!assert (disk_available('.') > 0)
