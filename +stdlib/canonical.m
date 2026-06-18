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
arguments
  file {mustBeTextScalar}
  strict (1,1) logical = false
end

c = '';

try
  p = filePermissions(file);
  c = p.AbsolutePath;
  if ischar(file)
    c = char(c);
  end
catch e
  if ~stdlib.strempty(file)
    switch e.identifier
      case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
        if ~strict
          c = stdlib.normalize(file);
        end
      case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
        [s, r] = fileattrib(file);
        if s == 1
          c = r.Name;
        elseif ~strict
          c = stdlib.normalize(file);
        end
      otherwise
        rethrow(e)
    end
  end

  if isstring(file)
    c = string(c);
  end
end

end
