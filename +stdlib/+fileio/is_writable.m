function ok = is_writable(file)
%% is_writable is file writable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)

arguments
  file string {mustBeScalarOrEmpty}
end

if isempty(file)
  ok = logical.empty;
  return
end


ok = java.nio.file.Files.isWritable(java.io.File(stdlib.fileio.absolute_path(file)).toPath());

end
