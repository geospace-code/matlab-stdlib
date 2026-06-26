function n = get_owner(file)

n = missing;

if stdlib.strempty(file)
  return
end

try
  n = char(py.pathlib.Path(file).owner());
catch e
  pythonException(e);
end

end
