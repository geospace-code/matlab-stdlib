%% JAVA.SAMEPATH are inputs the same path

function y = samepath(path1, path2)

try
  f1 = java.io.File(path1);
  f2 = java.io.File(path2);

  if f1.exists() && f2.exists()
    y = java.nio.file.Files.isSameFile(javaAbsolutePath(f1), javaAbsolutePath(f2));
  else
    y = false;
  end
catch e
  javaException(e)
  y = logical.empty;
end

end
