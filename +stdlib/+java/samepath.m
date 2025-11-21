function y = samepath(path1, path2)
% JAVA.SAMEPATH are inputs the same path

try
  f1 = javaObject('java.io.File', path1);
  f2 = javaObject('java.io.File', path2);

  if f1.exists() && f2.exists()
    p1 = javaAbsolutePath(f1);
    p2 = javaAbsolutePath(f2);
    y = javaMethod('isSameFile', 'java.nio.file.Files', p1, p2);
    % y = java.nio.file.Files.isSameFile(p1, p2);
  else
    y = false;
  end
catch e
  javaException(e)
  y = logical([]);
end

end
