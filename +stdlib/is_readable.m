%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%% Outputs
% ok: true if file is readable
% b: backend used

function [ok, b] = is_readable(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "native", "legacy"]
end

[fun, b] = hbackend(backend, "is_readable", 'R2025a');

if isscalar(file) || b == "native"
  ok = fun(file);
else
  ok = arrayfun(fun, file);
end

end
