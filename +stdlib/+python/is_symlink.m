function y = is_symlink(file)

if stdlib.strempty(file)
  y = false;
  return
end

try
  y = py.pathlib.Path(file).is_symlink();
catch
  y = logical.empty;
end

end
