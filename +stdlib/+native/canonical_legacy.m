function c = canonical_legacy(file, strict)

c = "";

if stdlib.strempty(file), return, end

[s, r] = fileattrib(file);

if s == 1
  c = r.Name;
elseif ~strict
  c = stdlib.normalize(file);
end

c = string(c);

end
