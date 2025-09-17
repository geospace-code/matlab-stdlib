%% MAKEDIR make directory and check for success
%
% malformed paths can be "created" but are not accessible.
% This function works around that bug in Matlab mkdir().
%
% Matlab < R2018a needs char input

function makedir(direc)

%% to avoid confusing making ./~/mydir
direc = stdlib.expanduser(direc);

if ~stdlib.strempty(direc) && ~isfolder(direc)
  [~] = mkdir(direc);
end

ok = isfolder(direc);

if nargout == 0
  assert(ok, 'Failed to create directory: %s', direc)
end

end
