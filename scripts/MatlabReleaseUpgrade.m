%% Finds the program "MathWorksUpdateInstaller" used to check for Matlab updates.
%
% The usual MathWorksUpdateInstaller program was removed in R2025a.
% There is another program under the Mathworks ServiceHost, but folks have
% observed that program results in network error code 1804. Nonetheless, we
% give the location of that program, hoping that the Mathworks will make a
% solution, perhaps via "mpm upgrade" in the future.
%
% future: programmatic update is planned for the "mpm" program:
% https://github.com/mathworks-ref-arch/matlab-dockerfile/issues/129#issuecomment-2783047083
%
% Ref: https://www.mathworks.com/matlabcentral/answers/1815365-how-do-i-uninstall-and-reinstall-the-mathworks-service-host

function MatlabReleaseUpgrade()

cmd = getUpgradePath();

fprintf("Matlab upgrade program found:\n\n%s\n\n", cmd)

end


function cmd = getUpgradePath()

name = "MathWorksUpdateInstaller";
if ispc()
  name = name + ".exe";
elseif isunix() && ~ismac()
  name = name + ".sh";
end

if isMATLABReleaseOlderThan('R2025a')
  cmd = legacy_update_path(name);
else
  cmd = new_update_path(name);
end

if ~isfile(cmd)
  error("Did not find upgrade program at %s", cmd)
end

end


function cmd = legacy_update_path(name)

r = fullfile(matlabroot, "bin", computer("arch"));
mustBeFolder(r)
cmd = fullfile(r, name);

end


function cmd = new_update_path(name)

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
  head = fullfile(getenv("HOME"), '.MathWorks/ServiceHost', getenv("HOSTNAME"));
end
mustBeFolder(head)

bin_tail = fullfile("bin", arch);

infoFile = fullfile(head, "LatestInstall.info");
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

cmd = fullfile(svcRoot, bin_tail, name);

end
