%% JAVA.READ_SYMLINK resolve the symbolic links of a filepath
% empty if no symlinks

function r = read_symlink(file)

% must be absolute path
% must not be .canonical or symlink is gobbled!
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#readSymbolicLink(java.nio.file.Path)
try
  r = string(java.nio.file.Files.readSymbolicLink(javaAbsolutePath(file)));
catch e
  javaException(e)
  r = "";
end

end
