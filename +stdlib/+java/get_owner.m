function n = get_owner(file)
% JAVA.GET_OWNER get owner of file
%
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#getOwner(java.nio.file.Path,java.nio.file.LinkOption...)
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/LinkOption.html

n = '';
if stdlib.strempty(file)
  return
end

% Java 1.8 benefits from absolute.
% We only saw this issue with R2025a on windows-2025 GA runner image.
%
% if stdlib.exists() was not adequate here, as on some CI systems, despite the same setup on a laptop working.
% stdlib.exists() was true, the Java function threw java.nio.file.NoSuchFileException.
%
% this try-catch is faster and more robust
try
  p = javaAbsolutePath(file);
  opt = javaMethod('values', 'java.nio.file.LinkOption');
  n = char(javaMethod('getOwner', 'java.nio.file.Files', p, opt));
catch e
  javaException(e)
end

end
