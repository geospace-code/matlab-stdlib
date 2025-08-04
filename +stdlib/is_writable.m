%% IS_WRITABLE is path writable
%
%%% Inputs
% file: path to file or folder
%% Outputs
% ok: true if file is writable

function y = is_writable(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "native", "legacy"]
end

fun = hbackend(backend, "is_writable", 'R2025a');

y = fun(file);

end
