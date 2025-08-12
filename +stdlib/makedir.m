%% MAKEDIR make directory and check for success
% malformed paths can be "created" but are not accessible.
% This function works around that bug in Matlab mkdir().

function makedir(direc)
arguments
  direc string
end

%% to avoid confusing making ./~/mydir
for i = numel(direc)
  direc(i) = stdlib.expanduser(direc(i));
end

i = ~stdlib.strempty(direc) & ~isfolder(direc);

for d = direc(i)
  [~] = mkdir(d);
end

ok = isfolder(direc(i));

if nargout == 0
  assert(all(ok), "Failed to create directories: %s", strjoin(direc(~ok), ", "));
end

end
