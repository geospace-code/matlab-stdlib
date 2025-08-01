disp(matlabRelease())

r = fullfile(matlabroot, "bin", computer("arch"));
mustBeFolder(r)

cmd = fullfile(r, "MathWorksUpdateInstaller");
if ispc()
  cmd = cmd + ".exe";
end

if ~isfile(cmd)
  if isMATLABReleaseOlderThan('R2025a')
    error("Did not find upgrade program at %s", cmd)
  else
    error("Matlab R2025a changed the upgrade process, use the GUI.")
  end
end

fprintf("Run this command in system Terminal to check for Matlab upgrade:\n\n%s\n\n", cmd)
