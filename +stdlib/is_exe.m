%% IS_EXE is file executable
%
% false if not a file

function y = is_exe(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "python", "native", "legacy"]
end

% Java or Python ~ 100x faster than Matlab native
fun = choose_method(method, "is_exe", 'R2025a');

y = fun(file);

end
