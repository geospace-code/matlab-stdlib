function r = read_symlink(file)

r = string.empty;

p = py.pathlib.Path(file);
if ~p.is_symlink()
  return
end

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink
try
  r = string(py.str(p.readlink()));
  if ispc() && startsWith(r, '\\?\')
    r = extractAfter(r, '\\?\');
  end
catch e
  warning(e.identifier, "read_symlink(%s) failed: %s", file, e.message);
end

end
