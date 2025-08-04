function r = read_symlink(p)

r = "";

if ~stdlib.is_symlink(p), return, end

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink
try
  r = string(py.os.readlink(p));
  if ispc() && startsWith(r, '\\?\')
    r = extractAfter(r, '\\?\');
  end
catch e
  warning(e.identifier, "read_symlink(%s) failed: %s", p, e.message);
end

end
