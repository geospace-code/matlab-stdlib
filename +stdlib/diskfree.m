%% DISKFREE disk free space
% returns disk free space in bytes
%
% example:  diskfree('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function f = diskfree(d)
arguments
  d (1,1) string {mustBeFolder}
end

if stdlib.isoctave()
  o = javaObject("java.io.File", d);
else
  o = java.io.File(d);
end

f = o.getUsableSpace();

end

%!assert (diskfree('.') > 0)
