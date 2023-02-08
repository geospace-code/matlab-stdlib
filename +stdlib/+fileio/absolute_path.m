function abspath = absolute_path(p)
%% absolute_path(p)
% path need not exist, but absolute path is returned
%
% NOTE: some network file systems are not resolvable by Matlab Java
% subsystem, but are sometimes still valid--so return
% unmodified path if this occurs.
%
%%% Inputs
% * p: path to make absolute
%%% Outputs
% * abspath: absolute path, if determined

arguments
  p string {mustBeScalarOrEmpty}
end

% have to expand ~ first
abspath = stdlib.fileio.expanduser(p);

if isempty(abspath)
  return
end

if ~stdlib.fileio.is_absolute_path(abspath)
  % otherwise the default is Documents/Matlab, which is probably not wanted.
  abspath = fullfile(pwd, abspath);
end

if ispc && startsWith(abspath, "\\")
  % UNC path is not canonicalized
  return
end
try
  abspath = string(java.io.File(abspath).getCanonicalPath());
catch excp
  if excp.identifier == "MATLAB:undefinedVarOrClass"
    % Java is not available, so return unmodified path
    return
  else
    error("stdlib:fileio:absolute_path", "%s is not a canonicalizable path.  %s", abspath, excp.message)
  end
end

end % function
