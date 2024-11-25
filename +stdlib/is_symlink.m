%% IS_SYMLINK is it a symbolic link
%
% Ref:
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSymbolicLink(java.nio.file.Path)

function ok = is_symlink(p)
arguments
  p (1,1) string
end

if isMATLABReleaseOlderThan("R2024b")
  % must be absolute path
  % NOT .canonical or symlink is gobbled!
  p = stdlib.absolute(p, "", false, true);
  ok = java.nio.file.Files.isSymbolicLink(java.io.File(p).toPath());
else
  ok = isSymbolicLink(p);
end

end
