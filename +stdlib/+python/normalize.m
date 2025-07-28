function n = normalize(p)

try
  n = string(py.os.path.normpath(p));
  n = strip(n, 'right', '/');
  if ispc()
    n = strip(n, 'right', filesep);
  end
catch e
  warning(e.identifier, "%s", e.message)
  n = "";
end