%% JAVA.READ_SYMLINK resolve the symbolic links of a filepath
% empty if no symlinks

function r = read_symlink(file)

% must be absolute path
% must not be .canonical or symlink is gobbled!
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
if stdlib.has_java()
  p = javaAbsolutePath(file);
  r = string(javaMethod('readSymbolicLink', 'java.nio.file.Files', p));
else
  r = missing;
end

end
