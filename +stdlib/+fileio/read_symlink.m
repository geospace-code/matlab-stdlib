function r = read_symlink(p)
%% read_symlink read symbolic link
arguments
  p (1,1) string
end

r = string.empty;

if isMATLABReleaseOlderThan("R2024b")

if ~stdlib.fileio.is_symlink(p) || ~stdlib.fileio.exists(p)
  return
end

r = stdlib.fileio.absolute_path(p);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
% must be absolute path
r = java.nio.file.Files.readSymbolicLink(java.io.File(r).toPath());

else
  [ok, t] = isSymbolicLink(p);
  if ok
    r = t;
  end
end
