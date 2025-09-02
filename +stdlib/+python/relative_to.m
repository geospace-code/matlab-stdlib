function rel = relative_to(base, other)

rel = "";

if stdlib.strempty(base) || stdlib.strempty(other)
  return
end

try
  rel = string(py.str(py.pathlib.Path(other).relative_to(base)));
catch e
  pythonException(e)
end

end
