%% GET_PERMISSIONS permissions of file or directory
%
% output is char like 'rwxrwxr--'
%
%%% inputs
% * file: path to check
%%% Outputs
% * p: permissions string
% * b: backend used

function [perm, b] = get_permissions(file)
arguments
  file (1,1) string {mustBeFileOrFolder}
end

if stdlib.matlabOlderThan('R2025a')
  perm = perm2char(file_attributes(file));
  b = 'legacy';
else
  perm = perm2char(filePermissions(file));
  b = 'native';
end

end
