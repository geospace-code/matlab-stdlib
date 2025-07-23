function n = py_get_owner(p)

n = string(py.str(py.pathlib.Path(p).owner()));

end
