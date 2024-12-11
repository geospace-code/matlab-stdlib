%% IS_WSL_PATH detect a WSL path
%
% Ref: https://learn.microsoft.com/en-us/windows/wsl/filesystems

function iswsl = is_wsl_path(p)
% arguments
%   p (1,1) string
% end

if ispc
  iswsl = strncmp(p, "\\wsl$", 6) || strncmp(p, "\\wsl.localhost", 15);
else
  iswsl = false;
end

end

%!assert(!is_wsl_path("C:/"))
