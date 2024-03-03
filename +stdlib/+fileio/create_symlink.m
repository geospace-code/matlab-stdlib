function ok = create_symlink(target, link)
%% create_symlink create symbolic link
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#createSymbolicLink(java.nio.file.Path,java.nio.file.Path,java.nio.file.attribute.FileAttribute...)

arguments
  target (1,1) string
  link (1,1) string
end

% import java.io.File
% import java.nio.file.Files
% ok = Files.createSymbolicLink(File(link).toPath(), File(target).toPath());
% the above should work, but Matlab Java doesn't recognize the optional argument omitted.

if stdlib.fileio.exists(link)
  warning("link %s already exists", link)
  ok = false;
  return
end

if ispc
  cmd = "pwsh -c " + '"' + "New-Item -ItemType SymbolicLink -Path " + link + " -Target " + target + '"';
else
  cmd = "ln -s " + target + " " + link;
end

% suppress output text on powershell
[stat, ~] = system(cmd);

ok = stat == 0;

end
