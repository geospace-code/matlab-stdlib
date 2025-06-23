%% CANONICAL Canonicalize path
% c = canonical(p);
% If exists, canonical absolute path is returned.
% if any component of path does not exist, normalized relative path is returned.
% UNC paths are not canonicalized.
%
% This also resolves Windows short paths to long paths.
%
%%% Inputs
% * p: path to make canonical
%%% Outputs
% * c: canonical path, if determined

function c = canonical(p)
arguments
  p {mustBeTextScalar}
end

c = "";

if ~strlength(p) || (ispc() && (startsWith(p, {'\\', '//'})))
  % UNC path is not canonicalized
  return
end

if stdlib.isoctave()
% empty if any component of path does not exist
  c = canonicalize_file_name(p);
else
% errors if any component of path does not exist.
% disp("builtin")
  try %#ok<TRYNC>
    c = builtin('_canonicalizepath', p);
  end
end

c = stdlib.posix(c);

if ~strlength(c)
  c = stdlib.normalize(p);
end

if isstring(p)
  c = string(c);
end

end

%!assert(canonical(""), "")
%!assert(canonical("~"), homedir())
