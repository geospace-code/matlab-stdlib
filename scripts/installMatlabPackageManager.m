function pexe = installMatlabPackageManager(installDir)
% installMatlabPackageManager Download and install official Matlab Package Manger (mpm)
%
% Ref: https://www.mathworks.com/help/install/ug/get-mpm-os-command-line.html
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
if isunix()
  root = fileparts(fileparts(mfilename('fullpath')));
  addpath(root)
  assert(stdlib.set_permissions(pexe, 0, 0, 1), sprintf('chmod +x %s', pexe))
end
