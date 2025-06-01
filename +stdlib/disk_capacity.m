%% DISK_CAPACITY disk total capacity (bytes)
% requires: mex or java
%
% example:  stdlib.disk_capacity('/')

function f = disk_capacity(d)
arguments
  d {mustBeTextScalar}
end

f = javaFileObject(d).getTotalSpace();

f = uint64(f);

end

%!assert (disk_capacity('.') > 0)
