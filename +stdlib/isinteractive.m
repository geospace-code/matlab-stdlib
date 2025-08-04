%% ISINTERACTIVE tell if being run interactively
%
% we try to consider the "-nodesktop" mode as interactive.
% * get(0,'ScreenSize') often isn't relable anymore, it will show a display
% size on HPC for example, maybe due to Xvfb or such.
% Nowadays (R2025a+) one can make plots without Java enabled -nojvm too.


function g = isinteractive()

if batchStartupOptionUsed()
  g = false;
elseif stdlib.is_matlab_online()
  g = true;
elseif isMATLABReleaseOlderThan('R2025a')
  g = usejava('desktop');
elseif feature('showFigureWindows')
  % this is true in matlab -batch by default
  g = true;
else
  % assume true to be 'safe'
  g = true;
end

end
