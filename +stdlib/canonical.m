%% CANONICAL Canonicalize path
% c = canonical(p);
% If exists, canonical absolute path is returned.
% if any component of path does not exist, normalized relative path is returned.
% UNC paths are not canonicalized.
%
% This also resolves Windows short paths to long paths.
%
%%% Inputs
% * file: path to make canonical
% * strict: if true, only return canonical path if it exists. If false, return normalized path if path does not exist.
%%% Outputs
% * c: string: canonical path or missing

function c = canonical(file, strict)
arguments
  file (1,1) string
  strict (1,1) logical = false
end

if strlength(file) == 0
  c = string(pwd());
elseif ~stdlib.exists(file)
  if strict
    c = missing;
    return
  end
  c = stdlib.normalize(file);
else

if stdlib.matlabOlderThan('R2026b')
  if stdlib.matlabOlderThan('R2025a')
    [s, r] = fileattrib(file);
    assert(s, 'stdlib:canonical', 'Error executing fileattrib(%s): %s', file, r);
    c = string(r.Name);
  else
    c = filePermissions(file).AbsolutePath;
  end
else
  c = resolveFilePath(file, 'ResolveSymbolicLinks', true);
end

end
