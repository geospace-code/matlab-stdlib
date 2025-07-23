function r = py_read_symlink(p)

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink
r = string(py.os.readlink(p));
if ispc() && startsWith(r, '\\?\')
  r = extractAfter(r, '\\?\');
end

end
