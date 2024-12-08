%% IS_WRITABLE is path writable
%
%!assert (is_writable('is_writable.m', false))
%!assert (is_writable('', false), false)

function ok = is_writable(file, use_java)
arguments
  file (1,1) string
  use_java (1,1) logical = false
end

if use_java
  % java is about 10x slower than fileattrib
  % needs absolute()
  file = stdlib.absolute(file, "", false, use_java);

  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)
  ok = java.nio.file.Files.isWritable(java.io.File(file).toPath());
else
  [status, v] = fileattrib(file);

  ok = status ~= 0 && (v.UserWrite || (~isnan(v.GroupWrite) && v.GroupWrite) || (~isnan(v.OtherWrite) && v.OtherWrite));
end

end
