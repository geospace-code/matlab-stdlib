%% JAVA.READ_SYMLINK resolve the symbolic links of a filepath
% empty if no symlinks

function r = read_symlink(p)

if stdlib.is_symlink(p)
  % must be absolute path
  % must not be .canonical or symlink is gobbled!
  r = stdlib.absolute(p);
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
  r = string(java.nio.file.Files.readSymbolicLink(javaPathObject(r)));
else
  r = string.empty;
end

end
