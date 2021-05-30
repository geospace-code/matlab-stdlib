function isinter = isinteractive()
%% tell if the program is being run interactively or not.

if stdlib.sys.isoctave
  isinter = isguirunning;
else
  % Matlab: this test doesn't work for Octave
  % don't use batchStartupOptionUsed as it neglects the "-nodesktop" case
  isinter = usejava('desktop');
end

end
