%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%% Outputs
% ok: true if file is readable

function y = is_readable(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "native", "legacy"]
end

[fun, b] = hbackend(backend, "is_readable", 'R2025a');

if isscalar(file) || b == "native"
  y = fun(file);
else
  y = arrayfun(fun, file);
end

end
