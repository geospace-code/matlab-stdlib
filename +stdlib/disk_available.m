%% DISK_AVAILABLE disk available space (bytes)
% requires: mex or java
%
% example:  stdlib.disk_available('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function f = disk_available(d)
arguments
  d {mustBeTextScalar}
end

f = javaFileObject(d).getUsableSpace();

f = uint64(f);

end

%!assert (disk_available('.') > 0)
