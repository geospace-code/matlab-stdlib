%% SET_PERMISSIONS set path permissions
% optional: mex
%
%%% Inputs
% * file
% * readable   (-1 remove read permission,    0 no change, 1 add read permission)
% * writable   (-1 remove write permission,   0 no change, 1 add write permission)
% * executable (-1 remove execute permission, 0 no change, 1 add execute permission)
%%% Outputs
% * ok (1,1) logical

function ok = set_permissions(file, readable, writable, executable, method)
arguments
  file {mustBeTextScalar}
  readable (1,1) {mustBeInteger, mustBeInRange(readable, -1, 1)}
  writable (1,1) {mustBeInteger, mustBeInRange(writable, -1, 1)}
  executable (1,1) {mustBeInteger, mustBeInRange(executable, -1, 1)}
  method (1,:) string = ["native", "legacy"]
end

fun = choose_method(method, "set_permissions", 'R2025a');

ok = fun(file, readable, writable, executable);

end
