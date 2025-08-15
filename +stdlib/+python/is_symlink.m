function y = is_symlink(file)
arguments
  file (1,1) string
end

try
  y = py.pathlib.Path(file).is_symlink();
catch
  y = logical.empty;
end

end
