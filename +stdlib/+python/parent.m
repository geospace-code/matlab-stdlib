function p = parent(pth)

try
  p = string(py.str(py.pathlib.Path(pth).parent));
  if ispc() && strcmp(p, stdlib.root_name(pth))
    p = strcat(p, filesep);
  end
catch e
  p = "";
  warning(e.identifier, "%s", e.message)
end

end
