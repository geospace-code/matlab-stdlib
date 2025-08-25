function y = is_symlink(file)

try
  y = py.pathlib.Path(file).is_symlink();
catch
  y = logical.empty;
end

end
