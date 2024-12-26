%% IS_WRITABLE is path writable
%
% non-existant file is false

function ok = is_writable(file, use_java)
arguments
  file (1,1) string
  use_java (1,1) logical = true
end

ok = false;
if ~stdlib.exists(file, use_java), return, end
% exists() check speeds up by factor of 50x on macOS for Java or non-Java


if use_java
  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)
  % java.nio.file.Files java is about 10x slower than fileattrib
  % needs absolute()
  % file = stdlib.absolute(file, "", false, true);
  % ok = java.nio.file.Files.isWritable(java.io.File(file).toPath());

ok = javaFileObject(file).canWrite();

else

[status, v] = fileattrib(file);

ok = status ~= 0 && (v.UserWrite || (~isnan(v.GroupWrite) && v.GroupWrite) || (~isnan(v.OtherWrite) && v.OtherWrite));

end

end

%!assert (is_writable('is_writable.m', 0))
%!assert (!is_writable('',0))
