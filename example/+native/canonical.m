function c = canonical(file, strict)
if nargin < 2
  strict = false;
end

rp = matlab.io.internal.filesystem.resolvePath(file);
c = string({rp.ResolvedPath});

if strict
  return
end

if stdlib.strempty(c) && ~stdlib.strempty(file)
  c = stdlib.normalize(file);
end

end
