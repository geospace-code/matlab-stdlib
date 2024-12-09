%% CREATE_SYMLINK create symbolic link
%
%%% Inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * ok: true if successful
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#createSymbolicLink(java.nio.file.Path,java.nio.file.Path,java.nio.file.attribute.FileAttribute...)

function ok = create_symlink(target, link)

arguments
  target (1,1) string
  link (1,1) string
end

if stdlib.isoctave()

  [err, msg] = symlink(target, link);
  ok = err == 0;
  if ~ok
    warning("symlink: %s", msg)
  end

elseif ispc || isMATLABReleaseOlderThan("R2024b")
% ok = java.nio.file.Files.createSymbolicLink(java.io.File(link).toPath(), java.io.File(target).toPath());
% the above should work, but Matlab Java doesn't recognize the optional argument omitted.

if stdlib.exists(link)
  ok = false;
  return
end

if ispc
  cmd = "pwsh -c " + '"' + "New-Item -ItemType SymbolicLink -Path " + link + ...
        " -Target " + target + '"';
else
  cmd = "ln -s " + target + " " + link;
end

% suppress output text on powershell
[stat, ~] = system(cmd);

ok = stat == 0;

else
% windows requires RunAsAdmin, so we don't use this on Windows
% https://www.mathworks.com/help/releases/R2024b/matlab/ref/createsymboliclink.html

  try
    createSymbolicLink(link, target);
    ok = true;
  catch
    ok = false;
  end

end

end

%!test
%! if !ispc
%!   create_symlink(tempname, tempname)
%! endif
