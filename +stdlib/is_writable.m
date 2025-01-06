%% IS_WRITABLE is path writable
%
% non-existant path is false

function ok = is_writable(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

ok = false;
if ~stdlib.exists(p), return, end
% exists() check speeds up by factor of 50x on macOS for Java or non-Java


if use_java
  % https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html#isWritable(java.nio.file.Path)
  % java.nio.file.Files java is about 10x slower than fileattrib
  % needs absolute()
  % file = stdlib.absolute(file, "", false, true);
  % ok = java.nio.file.Files.isWritable(javaPathObject(file));

ok = javaFileObject(p).canWrite();

else

a = file_attributes(p);
if isempty(a), return, end

ok = a.UserWrite || v.GroupWrite || v.OtherWrite;

end

%!assert (is_writable('is_writable.m', 0))
%!assert (!is_writable('',0))
