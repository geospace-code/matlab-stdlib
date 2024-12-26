%% IS_READABLE is file readable
%
% non-existant file is false

function ok = is_readable(file, use_java)
arguments
  file (1,1) string
  use_java (1,1) logical = true
end

ok = false;
if ~stdlib.exists(file, use_java), return, end
% exists() check speeds up by factor of 50x on macOS for Java or non-Java

if use_java
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)
  % java.nio.file.Files is about 10x slower than fileattrib
  % needs absolute()
  % file = stdlib.absolute(file, "", false, true);
  % ok = java.nio.file.Files.isReadable(java.io.File(file).toPath());

ok = javaFileObject(file).canRead();

else % use_java

[status, v] = fileattrib(file);

ok = status ~= 0 && (v.UserRead || (~isnan(v.GroupRead) && v.GroupRead) || (~isnan(v.OtherRead) && v.OtherRead));

end

end

%!assert (is_readable('is_readable.m', 0))
%!assert (!is_readable('', 0))
