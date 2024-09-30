function ok = is_writable(file, use_jvm)
%% is_writable
% is path writable
% https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)

arguments
  file (1,1) string
  use_jvm (1,1) logical = false
end

if use_jvm
  % java is about 10x slower than fileattrib
  % needs absolute()
  file = stdlib.absolute(file);

  ok = java.nio.file.Files.isWritable(java.io.File(file).toPath());
else
  [status, v] = fileattrib(file);

  ok = status ~= 0 && (v.UserWrite || (~isnan(v.GroupWrite) && v.GroupWrite) || (~isnan(v.OtherWrite) && v.OtherWrite));
end

end
