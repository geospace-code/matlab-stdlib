%% IS_WRITABLE is path writable
%
%%% Inputs
% file: path to file or folder
%% Outputs
% ok: true if file is writable

function y = is_writable(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "native", "legacy"]
end

fun = choose_method(method, "is_writable", 'R2025a');

y = fun(file);

end
