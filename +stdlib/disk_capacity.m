%% DISK_CAPACITY disk total capacity (bytes)
% requires: java
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(d)
arguments
  d (1,1) string
end

f = javaFileObject(d).getTotalSpace();

end

%!assert (disk_capacity('.') > 0)
