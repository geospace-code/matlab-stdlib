%% IS_WRITABLE is path writable
%
%%% Inputs
% * file: path to file or folder
% * backend: backend to use
%% Outputs
% * ok: true if file is writable
% * b: backend used

function [ok, b] = is_writable(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "native", "legacy"]
end

[fun, b] = hbackend(backend, "is_writable", 'R2025a');

if isscalar(file) || b == "native"
  ok = fun(file);
else
  ok = arrayfun(fun, file);
end

end
