function n = normalize(file)

try
  n = string(py.pathlib.Path(file).as_posix());
catch
  n = "";
end

end
