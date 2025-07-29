function p = parent(pth)

try
  p = string(py.str(py.pathlib.Path(pth).parent));
  if ispc() && p == stdlib.root_name(pth)
    p = p + filesep;
  end
catch e
  p = "";
  warning(e.identifier, "parent(%s) failed: %s", pth, e.message)
end

end
