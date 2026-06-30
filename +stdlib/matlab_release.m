%% MATLAB_RELEASE get current Matlab release
%
%%% Outputs
% * r: string of current Matlab release

function r = matlab_release()

if ~stdlib.matlabOlderThan('R2020b')
  r = matlabRelease().Release;
else
  r = "R" + version('-release');
end

end
