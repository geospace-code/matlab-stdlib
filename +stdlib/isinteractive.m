%% ISINTERACTIVE tell if graphical desktop is being used
%
% 'matlab -nodesktop' mode outputs false.
%
% * get(0,'ScreenSize') often isn't relable anymore, it will show a display
% size on HPC for example, maybe due to Xvfb or such.
% Nowadays (R2025a+) one can make plots without Java enabled -nojvm too.


function g = isinteractive()

if ~stdlib.matlabOlderThan('R2019b') && batchStartupOptionUsed()
  g = false;
else
  g = matlab.desktop.editor.isEditorAvailable() || ...
  (stdlib.matlabOlderThan('R2025a') && usejava('desktop')) || ...
  stdlib.is_matlab_online() || ...
  feature('showFigureWindows');
  % showFigureWindows is true in matlab -batch by default
end

end
