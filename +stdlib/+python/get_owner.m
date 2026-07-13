function n = get_owner(file)

if isunix()
  n = char(py.pathlib.Path(file).owner());
else
  n = missing;
end

end
