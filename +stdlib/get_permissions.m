%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'

function p = get_permissions(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["native", "legacy"]
end

fun = hbackend(backend, "get_permissions", 'R2025a');

p = fun(file);

end
