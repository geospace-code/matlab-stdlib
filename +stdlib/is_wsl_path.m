%% IS_WSL_PATH detect a WSL path
%
% Ref: https://learn.microsoft.com/en-us/windows/wsl/filesystems

function iswsl = is_wsl_path(p)
arguments
  p (1,1) string {mustBeNonzeroLengthText}
end

if ispc
  iswsl = any(startsWith(p, ["\\wsl$", "\\wsl.localhost"]));
else
  iswsl = false;
end

end
