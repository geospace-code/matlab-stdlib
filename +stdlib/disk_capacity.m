%% DISK_CAPACITY disk total capacity (bytes)
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(d)
arguments
  d {mustBeTextScalar}
end


if stdlib.has_dotnet()
  f = stdlib.dotnet.disk_capacity(d);
elseif stdlib.has_java()
  f = stdlib.java.disk_capacity(d);
elseif stdlib.has_python()
  f = stdlib.python.disk_capacity(d);
else
  f = stdlib.sys.disk_capacity(d);
end

end

%!assert (disk_capacity('.') > 0)
