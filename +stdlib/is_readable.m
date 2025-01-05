%% IS_READABLE is file readable
%
% non-existant file is false

function ok = is_readable(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

ok = false;
if ~stdlib.exists(p), return, end
% exists() check speeds up by factor of 50x on macOS for Java or non-Java

if use_java
  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)
  % java.nio.file.Files is about 10x slower than fileattrib
  % needs absolute()
  % file = stdlib.absolute(file, "", false, true);
  % ok = java.nio.file.Files.isReadable(java.io.File(file).toPath());

ok = javaFileObject(p).canRead();

else % use_java

[status, v] = fileattrib(p);

ok = status ~= 0 && (v.UserRead || (~isnan(v.GroupRead) && v.GroupRead) || (~isnan(v.OtherRead) && v.OtherRead));

end

end

%!assert (is_readable('is_readable.m', 0))
%!assert (!is_readable('', 0))
