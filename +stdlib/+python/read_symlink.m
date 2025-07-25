function r = read_symlink(p)

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink
try
  r = string(py.os.readlink(p));
  if ispc() && startsWith(r, '\\?\')
    r = extractAfter(r, '\\?\');
  end
catch e
  warning(e.identifier, "read_symlink(%s) failed: %s", p, e.message);
  r = string.empty;
end

end
