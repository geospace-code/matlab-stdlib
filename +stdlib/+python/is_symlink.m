function y = is_symlink(p)

try
  y = py.pathlib.Path(p).is_symlink();
catch e
  warning(e.identifier, "Python is_symlink failed: %s", e.message);
  y = false;
end

end
