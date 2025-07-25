%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(d)
arguments
  d {mustBeTextScalar}
end

f = uint64(0);

if ~stdlib.exists(d), return, end

if stdlib.has_dotnet()
  f = stdlib.dotnet.disk_capacity(d);
elseif stdlib.has_java()
  f = stdlib.java.disk_capacity(d);
elseif stdlib.has_python()
  f = stdlib.python.disk_capacity(d);
end

if f == 0
  f = stdlib.sys.disk_capacity(d);
end

f = uint64(f);

end

%!assert (disk_capacity('.') > 0)
