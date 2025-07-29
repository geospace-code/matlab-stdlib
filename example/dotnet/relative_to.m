%% DOTNET.RELATIVE_TO find the relative path to other from base
%
% not normally used because it's overly complex

function rel = relative_to(base, other)

assert(stdlib.dotnet_api() >= 5)

if stdlib.strempty(other)
  rel = base;
  return
end
if stdlib.strempty(base)
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
