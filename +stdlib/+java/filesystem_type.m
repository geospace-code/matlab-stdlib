%% JAVA.FILESYSTEM_TYPE


function t = filesystem_type(file)

% Java 1.8 benefits from absolute path, especially on Windows
%
% if stdlib.exists() was not adequate here, as on some CI systems, despite the same setup on a laptop working.
% stdlib.exists() was true, the Java function threw java.nio.file.NoSuchFileException.
%
if stdlib.has_java()
  p = javaAbsolutePath(file);
  s = javaMethod('getFileStore', 'java.nio.file.Files', p);
  t = char(s.type);
else
  t = missing;
end

end
