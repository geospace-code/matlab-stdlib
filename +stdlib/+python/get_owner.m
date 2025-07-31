function n = get_owner(p)

n = string.empty;
if ~stdlib.exists(p), return, end

try
  n = string(py.str(py.pathlib.Path(p).owner()));
catch e
  warning(e.identifier, "get_owner(%s) failed: %s", p, e.message)
end

end
