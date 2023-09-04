function makedir(direc)

arguments
  direc (1,1) string {mustBeNonzeroLengthText}
end

%% to avoid confusing making ./~/mydir
direc = stdlib.fileio.expanduser(direc);

if isfolder(direc)
  return
end

mkdir(direc);

assert(isfolder(direc), "stdlib:fileio:makedir:IOError", 'not a directory %s', direc)

end
