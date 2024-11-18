function isinter = isinteractive()
%% ISINTERACTIVE
% tell if the script is being run interactively

% Matlab: this test doesn't work for Octave
% don't use batchStartupOptionUsed as it neglects the "-nodesktop" case
isinter = usejava('desktop');

end
