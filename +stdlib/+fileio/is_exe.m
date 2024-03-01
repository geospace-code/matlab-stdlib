function ok = is_exe(file)
%% is_exe is file executable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#canExecute()

arguments
  file (1,1) string
end

ok = java.io.File(file).canExecute();

% more complicated
% ok = java.nio.file.Files.isExecutable(java.io.File(stdlib.fileio.absolute_path(file)).toPath());

end
