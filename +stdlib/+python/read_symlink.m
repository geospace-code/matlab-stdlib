function r = read_symlink(file)
arguments
  file (1,1) string
end

r = "";

if ~stdlib.is_symlink(file), return, end

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink
try
  r = string(py.os.readlink(file));
  if ispc() && startsWith(r, '\\?\')
    r = extractAfter(r, '\\?\');
  end
catch e
  warning(e.identifier, "read_symlink(%s) failed: %s", file, e.message);
end

end
