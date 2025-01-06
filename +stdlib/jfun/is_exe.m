%% IS_EXE is file executable

function ok = is_exe(p)

% about the same time as fileattrib
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#canExecute()
% more complicated
% ok = java.nio.file.Files.isExecutable(javaPathObject(stdlib.canonical(p)));

ok = javaFileObject(p).canExecute();

end