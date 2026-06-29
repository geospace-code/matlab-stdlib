function y = is_symlink(file)

if stdlib.has_python()
  y = py.pathlib.Path(file).is_symlink();
else
  y = missing;
end

end
