%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'

function p = get_permissions(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["native", "legacy"]
end

fun = choose_method(method, "get_permissions", 'R2025a');

p = fun(file);

end
