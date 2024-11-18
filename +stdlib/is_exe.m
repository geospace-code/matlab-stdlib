%% IS_EXE is file executable
%
% Ref: https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html#canExecute()

function ok = is_exe(file, use_java)
arguments
  file (1,1) string
  use_java (1,1) logical = false
end

if use_java
% about the same time as fileattrib
% doesn't need absolute path like other Java functions
ok = java.io.File(file).canExecute();

% more complicated
% ok = java.nio.file.Files.isExecutable(java.io.File(stdlib.canonical(file)).toPath());

else
  if strlength(file) == 0
    ok = false;
    return
  end

  [status, v] = fileattrib(file);

  ok = status ~= 0 && (v.UserExecute || (~isnan(v.GroupExecute) && v.GroupExecute) || (~isnan(v.OtherExecute) && v.OtherExecute));

end
end
