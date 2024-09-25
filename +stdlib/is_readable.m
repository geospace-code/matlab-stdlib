function ok = is_readable(file)
%% is_readable is file readable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)

arguments
  file (1,1) string
end

% needs absolute()
file = stdlib.absolute(file);

ok = java.nio.file.Files.isReadable(java.io.File(file).toPath());

end
