%% MATLAB_RELEASE get current Matlab release
%
%%% Outputs
% * r: string of current Matlab release

function r = matlab_release()

try
  r = matlabRelease().Release;
catch
  r = "R" + version('-release');
end

end
