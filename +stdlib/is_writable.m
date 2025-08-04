%% IS_WRITABLE is path writable
%
%%% Inputs
% file: path to file or folder
%% Outputs
% ok: true if file is writable

function y = is_writable(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "native", "legacy"]
end

[fun, b] = hbackend(backend, "is_writable", 'R2025a');

if isscalar(file) || b == "native"
  y = fun(file);
else
  y = arrayfun(fun, file);
end

end
