function owner = get_owner(p)
%% GET_OWNER owner of file or directory

arguments
  p (1,1) string
end

% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

opt = java.nio.file.LinkOption.values;

owner = string(java.nio.file.Files.getOwner(java.io.File(p).toPath(), opt));

end
