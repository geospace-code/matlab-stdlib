function y = is_symlink(p)

try
  y = py.pathlib.Path(p).is_symlink();
catch e
  y = logical.empty;
end

end
