function r = read_symlink(file)

p = py.pathlib.Path(file);

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink

r = string(py.str(p.readlink()));
if ispc() && startsWith(r, '\\?\')
  r = extractAfter(r, '\\?\');
end

end
