%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%% Outputs
% ok: true if file is readable

function y = is_readable(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "native", "legacy"]
end

fun = hbackend(backend, "is_readable", 'R2025a');

y = fun(file);

end
