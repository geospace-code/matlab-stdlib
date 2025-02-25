%% SET_PERMISSIONS set path permissions
% requires: mex
%
%%% Inputs
% * path (1,1) string
% * readable (1,1) int (-1 remove read permission, 0 no change, 1 add read permission)
% * writable (1,1) int (-1 remove write permission, 0 no change, 1 add write permission)
% * executable (1,1) int (-1 remove execute permission, 0 no change, 1 add execute permission)
%%% Outputs
% * ok (1,1) logical
%
% This function is written in C++ using STL <filesystem>
%
% TODO: R2025a final release add setPermissions
% https://www.mathworks.com/help/releases/R2025a/matlab/ref/matlab.io.filesystementrypermissions.setpermissions.html

function set_permissions(~, ~, ~, ~)
error("buildtool mex")
end
