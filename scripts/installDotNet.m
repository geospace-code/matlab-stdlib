%% INSTALL_DOTNET install the .NET SDK
% this can be used with dotnetenv() etc.
% https://www.mathworks.com/help/matlab/ref/dotnetenv.html

function installDir = installDotNet(installDir)
arguments
  installDir (1,1) string = ""
end

root = fileparts(fileparts(mfilename('fullpath')));
addpath(root)

if ispc()
  cmd = "winget install Microsoft.DotNet.SDK.9";
else

if ~strlength(installDir)
  if ispc()
    installDir = getenv('USERPROFILE');
  else
    installDir = getenv('HOME');
  end
  installDir = fullfile(installDir, '.dotnet');
end
if ~isfolder(installDir)
  mkdir(installDir);
end

url = 'https://dot.net/v1/dotnet-install.sh';

scr = websave(fullfile(installDir, 'dotnet-install.sh'), url);

cmd = sprintf('sh -c "%s --install-dir %s"', scr, installDir);

assert(stdlib.set_permissions(scr, 0, 0, 1), sprintf("chmod +x %s", scr))
end

disp(cmd)

s = system(cmd);
ok = 0;
if ispc()
  ok(end+1) = -1978335189;
end
if ~stdlib.is_matlab_online()
  assert(ismember(s, ok))
end

if isunix()
  setenv('DOTNET_ROOT', installDir)

  disp("add to " + fullfile(userpath, 'startup.m') + " the line:")
  disp("setenv('DOTNET_ROOT','" + installDir + "')")

  [~, m] = system(sprintf('%s/dotnet --info', installDir));
  disp(m)
end

assert(NET.isNETSupported)

dotnetenv()

end
