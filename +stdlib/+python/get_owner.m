function n = get_owner(p)

if ~stdlib.exists(p)
  n = string.empty;
  return
end

try
  n = string(py.str(py.pathlib.Path(p).owner()));
catch e
  warning(e.identifier, "get_owner(%s) failed: %s", p, e.message);
  n = string.empty;
end

end
