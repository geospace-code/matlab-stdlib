function abspath = absolute_path(p)

arguments
  p string {mustBeScalarOrEmpty}
end

% have to expand ~ first (like C++ filesystem::path::absolute)
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

% similar benchmark time as java method
% REQUIRES path to exist, while java method does not.
% abspath = builtin('_canonicalizepath', abspath);

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
