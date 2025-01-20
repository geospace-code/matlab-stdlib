%% UNLINK delete file or empty directory
% requires: mex
%
% Matlab or GNU Octave delete() has trouble with not being able to delete
% open files on Windows, this function overcomes that.
% Also, this function returns boolean success status, which factory
% delete() does not.
%
%%% Inputs
% * path (1,1) string
%%% Outputs
% * ok (1,1) logical
%
% This function is written in C++ using STL <filesystem>

function unlink(~)
error("buildtool mex")
end
