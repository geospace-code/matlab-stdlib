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
% * c: canonical path, if determined

function c = canonical(file, strict)
if nargin < 2
  strict = false;
end

c = '';

try
  p = filePermissions(file);
  c = p.AbsolutePath;
  if ischar(file)
    c = char(c);
  end
catch e
  switch e.identifier
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      if ~strict && ~stdlib.strempty(file)
        c = stdlib.normalize(file);
      end
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      [s, r] = fileAttribCompatible(file);
      if s == 1
        c = r.Name;
      elseif ~strict && ~stdlib.strempty(r)
        c = stdlib.normalize(file);
      end
    otherwise
      rethrow(e)
  end

  if isstring(file)
    c = string(c);
  end
end

end

%!assert (length(stdlib.canonical('.')) > 1)
