%% Finds the program "MathWorksUpdateInstaller" used to check for Matlab updates.
%
% The <matlabroot>/bin/<arch>/MathWorksUpdateInstaller program was removed in R2025a.
% There was long a second copy under the ServiceHost directory that we use instead.
%
% future: programmatic update is planned for the "mpm" program:
% https://github.com/mathworks-ref-arch/matlab-dockerfile/issues/129#issuecomment-2783047083
%
% References:
% * https://www.mathworks.com/matlabcentral/answers/2178694-mathworksupdateinstaller-and-r2025a-in-linux#answer_1568457
% * https://www.mathworks.com/matlabcentral/answers/1815365-how-do-i-uninstall-and-reinstall-the-mathworks-service-host

function MatlabReleaseUpgrade(doUpgrade)
arguments
  doUpgrade (1,1) logical = false
end

cmd = getUpgradePath();

fprintf("Matlab upgrade command:\n\n%s\n\n", cmd);

if doUpgrade
  s = system(cmd);
  assert(s == 0)
else
  disp("MatlabReleaseUpgrade(1) to install upgrade")
end

end


function cmd = getUpgradePath()

name = "MathWorksUpdateInstaller";
if ispc()
  name = name + ".exe";
elseif isunix() && ~ismac()
  name = name + ".sh";
end

if isMATLABReleaseOlderThan('R2025a')
  exe = legacy_update_path(name);
else
  exe = new_update_path(name);
end

if ~isfile(exe)
  error("Did not find upgrade program at %s", exe)
end

if ismac()
  exe = "'" + exe + "'";
end

cmd = sprintf('%s --destination %s', exe, matlabroot);

end


function exe = legacy_update_path(name)

r = fullfile(matlabroot, "bin", computer("arch"));
mustBeFolder(r)
exe = fullfile(r, name);

end


function exe = new_update_path(name)

arch = computer("arch");

if ismac()
  head = fullfile(getenv("HOME"), 'Library/Application Support/MathWorks');
  if ~isfolder(head)
    head = '/Library/Application Support/MathWorks';
  end
  head = fullfile(head, 'ServiceHost');
elseif ispc()
  head = fullfile(getenv("LOCALAPPDATA"), 'MathWorks/ServiceHost');
else
  hostname = string(javaMethod("getLocalHost", "java.net.InetAddress").getHostName());
  head = fullfile(getenv("HOME"), '.MathWorks/ServiceHost', hostname);
end
mustBeFolder(head)

bin_tail = fullfile("bin", arch);

infoFile = fullfile(head, "LatestInstall.info");
mustBeFile(infoFile)
fid = fopen(infoFile);
while ~feof(fid)
  svcRoot = extractAfter(fgetl(fid), "Latest" + optionalPattern("DS") + "InstallRoot");
  if ~isempty(svcRoot)
    svcRoot = strip(strip(svcRoot), '"');
    break
  end
end
fclose(fid);
mustBeNonempty(svcRoot)

exe = fullfile(svcRoot, bin_tail, name);

end
