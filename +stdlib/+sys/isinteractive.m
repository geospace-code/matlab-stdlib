function isinter = isinteractive()
%% isinteractive()
% tell if the script is being run interactively

if stdlib.sys.isoctave
  isinter = isguirunning;
else
  % Matlab: this test doesn't work for Octave
  % don't use batchStartupOptionUsed as it neglects the "-nodesktop" case
  isinter = usejava('desktop');
end

end
