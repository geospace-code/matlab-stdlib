%% SET_PERMISSIONS set path permissions
%
%%% Inputs
% * file
% * readable   (-1 remove read permission,    0 no change, 1 add read permission)
% * writable   (-1 remove write permission,   0 no change, 1 add write permission)
% * executable (-1 remove execute permission, 0 no change, 1 add execute permission)
%%% Outputs
% * ok (1,1) logical
% * b: backend used
%
% native backend is much more robust, if available

function [ok, b] = set_permissions(file, readable, writable, executable)
arguments
  file {mustBeTextScalar}
  readable (1,1) {mustBeInteger, mustBeMember(readable, [-1, 0, 1])}
  writable (1,1) {mustBeInteger, mustBeMember(writable, [-1, 0, 1])}
  executable (1,1) {mustBeInteger, mustBeMember(executable, [-1, 0, 1])}
end

if stdlib.matlabOlderThan('R2025a')
  ok = stdlib.legacy.set_permissions(file, readable, writable, executable);
  b = 'legacy';
else
  ok = stdlib.native.set_permissions(file, readable, writable, executable);
  b = 'native';
end

end
