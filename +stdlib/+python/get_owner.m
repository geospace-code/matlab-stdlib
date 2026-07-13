function n = get_owner(file)

n = char(py.pathlib.Path(file).owner());

end
