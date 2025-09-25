%% JAVA.FILESYSTEM_TYPE


function t = filesystem_type(file)

t = '';
if stdlib.strempty(file)
  return
end

try
% Java 1.8 benefits from absolute path, especially on Windows
%
% if stdlib.exists() was not adequate here, as on some CI systems, despite the same setup on a laptop working.
% stdlib.exists() was true, the Java function threw java.nio.file.NoSuchFileException.
%
% this try-catch is faster and more robust
  p = javaAbsolutePath(file);
  s = javaMethod('getFileStore', 'java.nio.file.Files', p);
  t = char(s.type);
catch e
  javaException(e)
end

end
