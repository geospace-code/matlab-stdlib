function owner = get_owner(path)
arguments
  path (1,1) string
end

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

opt = java.nio.file.LinkOption.values;

owner = string(java.nio.file.Files.getOwner(java.io.File(path).toPath(), opt));

end
