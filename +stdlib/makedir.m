function makedir(direc)
%% makedir(direc)
% malformed paths can be "created" but are not accessible.
% This function works around that bug in Matlab mkdir().
arguments
  direc (1,1) string {mustBeNonzeroLengthText}
end

%% to avoid confusing making ./~/mydir
direc = stdlib.expanduser(direc);

if isfolder(direc)
  return
end

mkdir(direc);

mustBeFolder(direc)

end
