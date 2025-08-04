%% IS_EXE is file executable
%
% false if not a file

function y = is_exe(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "native", "legacy"]
end

% Java or Python ~ 100x faster than Matlab native
fun = hbackend(backend, "is_exe", 'R2025a');

y = fun(file);

end
