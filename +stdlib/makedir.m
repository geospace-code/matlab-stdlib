%% MAKEDIR make directory and check for success
%
% malformed paths can be 'created' but are not accessible.
% This function works around that bug in Matlab mkdir().
% ok is true even if direc already exists.
%
% Matlab < R2018a needs char input

function ok = makedir(direc)
arguments
  direc {mustBeTextScalar}
end

%% to avoid confusing making ./~/mydir
direc = stdlib.expanduser(direc);

ok = false;

if ~stdlib.strempty(direc)
  [s, ~] = mkdir(direc);
  ok = s == 1;
end

ok = ok && isfolder(direc);

if nargout == 0
  assert(ok, 'Failed to create directory: %s', direc)
end

end
