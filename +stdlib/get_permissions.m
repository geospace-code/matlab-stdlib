%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'
%
%% Inputs
% * file: path to check
%% Outputs
% * p: permissions string
% * b: backend used

function [p, b] = get_permissions(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["native", "legacy"]
end

[fun, b] = hbackend(backend, "get_permissions", 'R2025a');

p = fun(file);

end
