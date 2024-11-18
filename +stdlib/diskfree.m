%% DISKFREE disk free space
% returns disk free space in bytes
%
% example:  diskfree('/')
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function freebytes = diskfree(d)
arguments
  d (1,1) string {mustBeFolder}
end

freebytes = java.io.File(d).getUsableSpace;

end
