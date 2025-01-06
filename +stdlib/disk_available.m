%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function f = disk_available(d)
arguments
  d (1,1) string
end

f = javaFileObject(d).getUsableSpace();

end

%!assert (disk_available('.') > 0)
