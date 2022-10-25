function freebytes = diskfree(direc)
%% diskfree(direc)
% returns disk free space in bytes
% example:  diskfree('~')
arguments
  direc (1,1) string
end

import stdlib.fileio.expanduser

direc = expanduser(direc);

assert(isfolder(direc), '%s is not a folder', direc)

freebytes = java.io.File(direc).getUsableSpace;

end
