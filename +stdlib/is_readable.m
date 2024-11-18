function ok = is_readable(file, use_java)
%% IS_READABLE is file readable
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)

arguments
  file (1,1) string
  use_java (1,1) logical = false
end

if use_java
  % java is about 10x slower than fileattrib
  % needs absolute()
  file = stdlib.absolute(file, string.empty, false, use_java);

  ok = java.nio.file.Files.isReadable(java.io.File(file).toPath());
else
  [status, v] = fileattrib(file);

  ok = status ~= 0 && (v.UserRead || (~isnan(v.GroupRead) && v.GroupRead) || (~isnan(v.OtherRead) && v.OtherRead));
end

end
