%% ISINTERACTIVE tell if being run interactively
%
% Matlab-only as this test doesn't work for Octave.
%
% NOTE: don't use batchStartupOptionUsed as it neglects the "-nodesktop" case

function isinter = isinteractive()
isinter = usejava('desktop');
end
