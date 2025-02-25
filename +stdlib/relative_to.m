%% RELATIVE_TO relative path to base
% requires: mex
%
%%% Inputs
% * base (1,1) string
% * other (1,1) string
%%% Outputs
% * rel (1,1) string
%
% This function is written in C++ using STL <filesystem>
%
% Note: Java Path.relativize has an algorithm so different that we choose not to use it.
% https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html#relativize-java.nio.file.Path-

function relative_to(~,~)
error("buildtool mex")
end
