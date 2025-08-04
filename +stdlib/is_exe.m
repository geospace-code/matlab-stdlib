%% IS_EXE is file executable
%
% false if not a file

function y = is_exe(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "python", "native", "legacy"]
end

% Java or Python ~ 100x faster than Matlab native
[fun, b] = hbackend(backend, "is_exe", 'R2025a');

if isscalar(file) || b == "native"
  y = fun(file);
else
  y = arrayfun(fun, file);
end

end
