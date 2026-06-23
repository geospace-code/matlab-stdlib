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
  file {mustBeTextScalar}
end

if stdlib.matlabOlderThan('R2025a')
  if ~stdlib.exists(file)
    error('MATLAB:io:filesystem:filePermissions:CannotFindLocation', '%s', file)
  end
  perm = perm2char(file_attributes(file));
  b = 'legacy';
else
  perm = perm2char(filePermissions(file));
  b = 'native';
end

end
