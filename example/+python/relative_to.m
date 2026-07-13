function rel = relative_to(base, target)
arguments
  base (1,1) string
  target (1,1) string
end

rel = missing;

if stdlib.strempty(base) || stdlib.strempty(target)
  return
end

rel = string(py.str(py.pathlib.Path(target).relative_to(base)));

end
