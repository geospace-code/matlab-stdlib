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

function [ok, b] = set_permissions(file, readable, writable, executable)
arguments
  file (1,1) string
  readable (1,1) {mustBeInteger}
  writable (1,1) {mustBeInteger}
  executable (1,1) {mustBeInteger}
end

b = '';

if ~stdlib.exists(file)
  ok = false;
  return
end

try
  ok = stdlib.native.set_permissions(file, readable, writable, executable);
  b = 'native';
catch e
  if e.identifier ~= "MATLAB:UndefinedFunction"
    rethrow(e)
  end

  ok = stdlib.legacy.set_permissions(file, readable, writable, executable);
  b = 'legacy';
end

end
