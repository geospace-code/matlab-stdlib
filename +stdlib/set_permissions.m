%% SET_PERMISSIONS set path permissions
%
%%% Inputs
% * file
% * readable   (-1 remove read permission,    0 no change, 1 add read permission)
% * writable   (-1 remove write permission,   0 no change, 1 add write permission)
% * executable (-1 remove execute permission, 0 no change, 1 add execute permission)
% * backend: backend to use
%%% Outputs
% * ok (1,1) logical
% * b: backend used

function [ok, b] = set_permissions(file, readable, writable, executable, backend)
arguments
  file (1,1) string
  readable (1,1) {mustBeInteger}
  writable (1,1) {mustBeInteger}
  executable (1,1) {mustBeInteger}
  backend (1,:) string = ["native", "legacy"]
end

o = stdlib.Backend(mfilename(), backend);

ok = o.func(file, readable, writable, executable);
b = o.backend;

end
