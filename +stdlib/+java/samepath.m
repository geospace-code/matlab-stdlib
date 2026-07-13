%% JAVA.SAMEPATH are inputs the same path

function y = samepath(path1, path2)

y = java.nio.file.Files.isSameFile(javaAbsolutePath(path1), javaAbsolutePath(path2));

end
