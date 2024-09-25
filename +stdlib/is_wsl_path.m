function iswsl = is_wsl_path(path)
% heuristic to detect a WSL path
% https://learn.microsoft.com/en-us/windows/wsl/filesystems
arguments
  path (1,1) string {mustBeNonzeroLengthText}
end

if ispc
  iswsl = any(startsWith(path, ["\\wsl$", "\\wsl.localhost"]));
else
  iswsl = false;
end

end
