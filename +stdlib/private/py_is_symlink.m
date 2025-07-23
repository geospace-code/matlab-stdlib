function y = py_is_symlink(p)

y = py.pathlib.Path(p).is_symlink();

end
