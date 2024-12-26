%% DISKFREE disk free space
% returns disk free space in bytes
%
% example:  diskfree('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function f = diskfree(d)
arguments
  d (1,1) string
end

f = javaFileObject(d).getUsableSpace();

end

%!assert (diskfree('.') > 0)
