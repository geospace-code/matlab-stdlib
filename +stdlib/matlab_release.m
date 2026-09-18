%% MATLAB_RELEASE get current Matlab release
%
%%% Outputs
% * r: string of current Matlab release

function r = matlab_release()

r = matlabRelease().Release;

end
