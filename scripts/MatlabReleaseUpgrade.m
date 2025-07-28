disp(matlabRelease())

assert(isMATLABReleaseOlderThan('R2025a'), "Matlab R2025a changed the upgrade process, use the GUI.")

r = fullfile(matlabroot, "bin", computer("arch"));
cmd = fullfile(r, "MathWorksUpdateInstaller");
if ispc()
  cmd = cmd + ".exe";
end

assert(isfile(cmd), "MathWorks Update Installer not found at %s", cmd)

fprintf("Run this command in Terminal to check for Matlab upgrade:\n\n%s\n\n", cmd)
