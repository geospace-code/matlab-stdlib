%% SET_PERMISSIONS set path permissions (Matlab requires MEX)
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

function set_permissions(~, ~, ~, ~)
error("buildtool mex")
end
