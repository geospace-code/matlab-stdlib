function n = get_owner(file)
arguments
  file (1,1) string
end

n = "";

if stdlib.strempty(file), return, end

try %#ok<TRYNC>
  n = string(py.pathlib.Path(file).owner());
end

end
