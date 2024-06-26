function ok = is_symlink(p)
%% is_symlink is path symbolic link
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSymbolicLink(java.nio.file.Path)

arguments
  p (1,1) string
end

if isMATLABReleaseOlderThan("R2024b")
  % must be absolute path
  p = stdlib.fileio.absolute_path(p);
  ok = java.nio.file.Files.isSymbolicLink(java.io.File(p).toPath());
else
  ok = isSymbolicLink(p);
end

end
