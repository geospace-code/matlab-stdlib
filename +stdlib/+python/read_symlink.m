function r = read_symlink(file)

r = string.empty;

try
  p = py.pathlib.Path(file);
  if ~p.is_symlink()
    return
  end

% https://docs.python.org/3/library/pathlib.html#pathlib.Path.readlink

  r = string(py.str(p.readlink()));
  if ispc() && startsWith(r, '\\?\')
    r = extractAfter(r, '\\?\');
  end
catch e
  pythonException(e)
end

end
