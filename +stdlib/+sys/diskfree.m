function freebytes = diskfree(direc)
%% diskfree(direc)
% returns disk free space in bytes
% example:  diskfree('/')
arguments
  direc (1,1) string {mustBeFolder}
end

freebytes = java.io.File(direc).getUsableSpace;

end
