function c = canonical(file)

[s, r] = fileattrib(file);
if s == 1
  c = r.Name;
else
  c = missing;
end

end
