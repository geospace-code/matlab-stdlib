%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p)

f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep)));

end
