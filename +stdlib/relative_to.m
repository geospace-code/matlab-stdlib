%% RELATIVE_TO relative path to base
%
%%% Inputs
% * base {mustBeTextScalar}
% * other {mustBeTextScalar}
%%% Outputs
% * rel {mustBeTextScalar}
%
% Note: Java Path.relativize has an algorithm so different that we choose not to use it.
% javaPathObject(base).relativize(javaPathObject(other))
% https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html#relativize-java.nio.file.Path-

function rel = relative_to(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end

if (strempty(base) && strempty(other)) || ...
   (stdlib.is_absolute(base) ~= stdlib.is_absolute(other))
  rel = "";
  return
end

if stdlib.has_python()
  rel = relative_to_python(base, other);
elseif stdlib.dotnet_api() >= 5
  rel = relative_to_dotnet(base, other);
else
  error('no supported relative path method found, please install .NET or "buildtool mex"')
end

end


function rel = relative_to_dotnet(base, other)

if strempty(other)
  rel = base;
  return
end
if strempty(base)
  rel = other;
  return
end

base = fullfile(base);
other = fullfile(other);

if stdlib.is_absolute(base) && ~(startsWith(base, other) || startsWith(other, base))
  rel = "";
else
  % https://learn.microsoft.com/en-us/dotnet/api/system.io.path.getrelativepath
  rel = string(System.IO.Path.GetRelativePath(base, other));
end

end


function rel = relative_to_python(base, other)

try
  rel = string(py.os.path.relpath(other, base));
catch e
  if e.identifier == "MATLAB:Python:PyException" && startsWith(e.message, 'Python Error: ValueError')
    rel = "";
  else
    rethrow(e)
  end
end

end

%!testif 0
