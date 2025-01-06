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
  % file = stdlib.absolute(file, "", false, true);
  % ok = java.nio.file.Files.isReadable(javaPathObject(file));

ok = javaFileObject(p).canRead();

else

a = file_attributes(p);
if isempty(a), return, end

ok = a.UserRead || v.GroupRead || v.OtherRead;

end

%!assert (is_readable('is_readable.m', 0))
%!assert (!is_readable('', 0))
