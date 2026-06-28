function n = get_owner(file)

if isunix() && stdlib.has_python()
  n = char(py.pathlib.Path(file).owner());
else
  n = missing;
end

end
