function c = canonical(file, strict)

if stdlib.strempty(file)
  c = "";
  return
end

p = matlab.io.internal.filesystem.resolvePath(file);
c = p.ResolvedPath;

if ~strict && stdlib.strempty(c)
  c = string(stdlib.normalize(file));
end

end
