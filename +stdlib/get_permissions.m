%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'
%
%% Inputs
% * file: path to check
% * backend: backend to use
%% Outputs
% * p: permissions string
% * b: backend used

function [perm, b] = get_permissions(file, backend)
arguments
  file (1,1) string
  backend (1,:) string = ["native", "legacy"]
end

o = stdlib.Backend(mfilename(), backend);
perm = o.func(file);
b = o.backend;

end
