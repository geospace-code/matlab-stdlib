%% RELATIVE_TO relative path to base
% optional: mex
%
%%% Inputs
% * base {mustBeTextScalar}
% * other {mustBeTextScalar}
%%% Outputs
% * rel {mustBeTextScalar}
%
% Note: Java Path.relativize has an algorithm so different that we choose not to use it.
% https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html#relativize-java.nio.file.Path-

function rel = relative_to(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end


if stdlib.has_dotnet() && stdlib.dotnet_api() >= 5

  if strempty(base) && strempty(other), rel = "."; return, end

  if strempty(other), rel = base; return, end
  if strempty(base), rel = other; return, end

  bis = stdlib.is_absolute(base);
  ois = stdlib.is_absolute(other);

  if bis ~= ois, rel = ""; return, end

  base = fullfile(base);
  other = fullfile(other);

  if bis && ~(startsWith(base, other) || startsWith(other, base))
    rel = "";
  else
    % https://learn.microsoft.com/en-us/dotnet/api/system.io.path.getrelativepath
    rel = string(System.IO.Path.GetRelativePath(base, other));
  end
else
  error('no supported relative path method found, please install .NET or "buildtool mex"')
end

end

%!testif 0
