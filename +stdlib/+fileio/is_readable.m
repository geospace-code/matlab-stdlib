function ok = is_readable(file)
%% is_readable is file readable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)

arguments
  file string {mustBeScalarOrEmpty}
end

if isempty(file)
  ok = logical.empty;
  return
end


ok = java.nio.file.Files.isReadable(java.io.File(stdlib.fileio.absolute_path(file)).toPath());

end
