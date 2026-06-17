%% MATLAB_RELEASE get current Matlab release
%
%%% Outputs
% * r: char of current Matlab release

function r = matlab_release()

try
  r = char(matlabRelease().Release);
catch
  r = ['R' version('-release')];
end

end
