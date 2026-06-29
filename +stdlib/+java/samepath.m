%% JAVA.SAMEPATH are inputs the same path

function y = samepath(path1, path2)

if stdlib.has_java()
  p1 = javaAbsolutePath(path1);
  p2 = javaAbsolutePath(path2);
  y = javaMethod('isSameFile', 'java.nio.file.Files', p1, p2);
  % y = java.nio.file.Files.isSameFile(p1, p2);
else
  y = missing;
end

end
