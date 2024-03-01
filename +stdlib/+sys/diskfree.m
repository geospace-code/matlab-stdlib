function freebytes = diskfree(direc)
%% diskfree(direc)
% returns disk free space in bytes
% example:  diskfree('/')
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()
arguments
  direc (1,1) string {mustBeFolder}
end

freebytes = java.io.File(direc).getUsableSpace;

end
