function y = is_symlink(file)

y = py.pathlib.Path(file).is_symlink();

end
