function c = canonical(file, strict)
arguments
  file (1,1) string
  strict (1,1) logical = false
end

c = "";

if stdlib.strempty(file)
  return
end

[s, r] = fileattrib(file);

if s == 1
  c = r.Name;
elseif ~strict
  c = stdlib.normalize(file);
end

c = string(c);

end
