function makedir(direc)
%% makedir(direc)
% malformed paths can be "created" but are not accessible.
% This function works around that bug in Matlab mkdir().
arguments
  direc (1,1) string {mustBeNonzeroLengthText}
end

direc = stdlib.fileio.expanduser(direc);

if isfolder(direc)
  return
end

mkdir(direc);

assert(isfolder(direc), "stdlib:fileio:makedir:IOError", 'not a directory %s', direc)

end
