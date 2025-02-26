disp(matlabRelease())

r = fullfile(matlabroot, "bin", computer("arch"));
cmd = fullfile(r, "MathWorksUpdateInstaller");

fprintf("Run this command in Terminal to check for Matlab upgrade:\n\n%s\n\n", cmd)
