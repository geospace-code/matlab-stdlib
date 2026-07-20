%% MAKEDIR make directory and check for success
%
% malformed paths can be 'created' but are not accessible.
% This function works around that bug in Matlab mkdir().
% ok is true even if direc already exists.

function ok = makedir(direc)
arguments
  direc {mustBeTextScalar,mustBeNonzeroLengthText}
end

%% to avoid confusing making ./~/mydir
direc = stdlib.expanduser(direc);

[ok, err] = mkdir(direc);

ok = ok && isfolder(direc);

if nargout == 0
  assert(ok, 'Failed to create directory: %s  %s', direc, err)
  clear('ok')
end

end
