function iswsl = is_wsl_path(path)
arguments
  path (1,1) string
end

if ispc
  iswsl = any(startsWith(path, ["\\wsl$", "\\wsl.localhost"]));
else
  iswsl = false;
end

end
