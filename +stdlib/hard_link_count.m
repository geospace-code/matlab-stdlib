function c = hard_link_count(filepath)
% HARD_LINK_COUNT get the number of hard links to a file
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#getPosixFileAttributes(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/javase/tutorial/essential/io/links.html
arguments
  filepath (1,1) string {mustBeFile}
end

if ispc
  c = [];
  return
end

opt = java.nio.file.LinkOption.values;

c = java.nio.file.Files.getAttribute(java.io.File(filepath).toPath(), "unix:nlink", opt);
  %Files.getAttribute(filePath, "unix:nlink")

end
