function n = get_owner(p)

if stdlib.exists(p)
  n = string(py.str(py.pathlib.Path(p).owner()));
else
  n = "";
end

end
