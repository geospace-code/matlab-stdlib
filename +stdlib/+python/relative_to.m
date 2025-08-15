function rel = relative_to(base, other)
arguments
  base (1,1) string
  other (1,1) string
end

try
  rel = string(py.os.path.relpath(other, base));
catch
  rel = "";
end

end
