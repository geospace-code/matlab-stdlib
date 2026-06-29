%% SET_PERMISSIONS set path permissions
%
%%% Inputs
% * file
% * readable   (false remove read permission, true add read permission, empty no change)
% * writable   (false remove write permission, true add write permission, empty no change)
% * executable (false remove execute permission, true add execute permission, empty no change)
%%% Outputs
% * ok (1,1) logical
% * b: backend used
%
% native backend is much more robust, if available

function [ok, b] = set_permissions(file, readable, writable, executable)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
  readable logical {mustBeScalarOrEmpty} = []
  writable logical {mustBeScalarOrEmpty} = []
  executable logical {mustBeScalarOrEmpty} = []
end

if stdlib.matlabOlderThan('R2025a')
  ok = stdlib.legacy.set_permissions(file, readable, writable, executable);
  b = 'legacy';
else
  ok = stdlib.native.set_permissions(file, readable, writable, executable);
  b = 'native';
end

end
