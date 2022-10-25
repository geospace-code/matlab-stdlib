function abspath = absolute_path(p)
%% absolute_path(p)
% path need not exist, but absolute path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
%% Inputs
% * p: path to make absolute
%% Outputs
% * abspath: absolute path, if determined

arguments
  p (1,:) string
end

% have to expand ~ first
p = stdlib.fileio.expanduser(p);

if ~stdlib.fileio.is_absolute_path(p)
  % otherwise the default is Documents/Matlab, which is probably not wanted.
  p = fullfile(pwd, p);
end

abspath = p;

for i = 1:length(abspath)
  if ispc && startsWith(abspath(i), "\\")
    % UNC path is not canonicalized
    continue
  end
  try
    abspath(i) = string(java.io.File(abspath(i)).getCanonicalPath());
  catch excp
    error("stdlib:fileio:absolute_path", "%s is not a canonicalizable path.  %s", abspath(i), excp.message)
  end
end

end % function
