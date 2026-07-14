%% Download and install official Matlab Package Manger (mpm)
% https://www.mathworks.com/help/install/ug/get-mpm-os-command-line.html

function pexe = installMatlabPackageManager(installDir)
arguments
  installDir (1,1) string = fileparts(mfilename('fullpath'))
end

arch = computer('arch');

url = sprintf('https://www.mathworks.com/mpm/%s/mpm', arch);

exe = 'mpm';
if ispc()
  exe = 'mpm.exe';
end
pexe = fullfile(installDir, exe);

pexe = websave(pexe, url);

fprintf('installed MPM %s\n', pexe);

% make the program executable
if isunix() && ~isMATLABReleaseOlderThan('R2025a')
  setPermissions(filePermissions(pexe), "UserExecute", true);
  fprintf('chmod +x %s\n', pexe);
end
