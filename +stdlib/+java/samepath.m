%% JAVA.SAMEPATH are inputs the same path

function y = samepath(path1, path2)
arguments
  path1 (1,1) string
  path2 (1,1) string
end

if stdlib.exists(path1) && stdlib.exists(path2)
  j1 = javaPathObject(stdlib.absolute(path1));
  j2 = javaPathObject(stdlib.absolute(path2));

  y = java.nio.file.Files.isSameFile(j1, j2);
else
  y = false;
end

end
