function n = get_owner(file)

n = "";

if ~strlength(file), return, end

try %#ok<TRYNC>
  n = string(py.str(py.pathlib.Path(file).owner()));
end

end
