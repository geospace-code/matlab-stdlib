%% IS_READABLE is file readable
%
%%% Inputs
% file: single path string
%% Outputs
% ok: true if file is readable

function y = is_readable(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "native", "legacy"]
end

fun = choose_method(method, "is_readable", 'R2025a');

y = fun(file);

end
