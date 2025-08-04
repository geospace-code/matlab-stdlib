function n = get_owner(p)

n = '';
if ~stdlib.exists(p)
  return
end

try
  n = char(py.str(py.pathlib.Path(p).owner()));
catch e
  warning(e.identifier, "get_owner(%s) failed: %s", p, e.message)
end

end
