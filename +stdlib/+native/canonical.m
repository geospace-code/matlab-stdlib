function c = canonical(file, strict)
arguments
  file string
  strict (1,1) logical = false
end

try
  rp = matlab.io.internal.filesystem.resolvePath(file);
  c = string({rp.ResolvedPath});
catch
  c = "";
  return
end

if strict
  return
end

for i = 1:numel(file)
  if strlength(c(i)) == 0 && strlength(file(i)) > 0
    c(i) = stdlib.normalize(file(i));
  end
end

end
