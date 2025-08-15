function n = normalize(file)
arguments
  file (1,1) string
end

try
  n = string(py.os.path.normpath(file));
  n = strip(n, 'right', '/');
  if ispc()
    n = strip(n, 'right', filesep);
  end
catch
  n = "";
end
