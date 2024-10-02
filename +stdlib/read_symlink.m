function r = read_symlink(p)
%% read_symlink read symbolic link
arguments
  p (1,1) string
end

r = string.empty;

if isMATLABReleaseOlderThan("R2024b")

if ~stdlib.is_symlink(p)
  return
end

% must be absolute path
% must not be .canonical or symlink is gobbled!
r = stdlib.absolute(p, string.empty, false, true);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
t = java.nio.file.Files.readSymbolicLink(java.io.File(r).toPath());

else
  [ok, t] = isSymbolicLink(p);
  if ~ok, return, end
end

r = stdlib.posix(t);

end
