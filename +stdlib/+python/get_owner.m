function n = get_owner(p)

try
  n = string(py.str(py.pathlib.Path(p).owner()));
catch e
  warning(e.identifier, "get_owner(%s) failed: %s", p, e.message);
  n = string.empty;
end

end
