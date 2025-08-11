%% IS_EXE is file executable
% does not check if the file is actually a binary executable
%
%% Inputs
% file: path to check
%% Outputs
% ok: true if path is a file and has executable permissions
% b: backend used

function [ok, b] = is_exe(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "python", "native", "legacy"]
end

% Java or Python ~ 100x faster than Matlab native
[fun, b] = hbackend(backend, "is_exe", 'R2025a');

if isscalar(file) || b == "native"
  ok = fun(file);
else
  ok = arrayfun(fun, file);
end

end
