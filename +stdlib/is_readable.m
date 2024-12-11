%% IS_READABLE is file readable
%
% non-existant file is false

function ok = is_readable(file, use_java)
% arguments
%   file (1,1) string
%   use_java (1,1) logical = false
% end
if nargin < 2, use_java = false; end

if use_java
  % java is about 10x slower than fileattrib
  % needs absolute()
  file = stdlib.absolute(file, "", false, use_java);

  % https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isReadable(java.nio.file.Path)
  ok = java.nio.file.Files.isReadable(java.io.File(file).toPath());
else
  [status, v] = fileattrib(file);

  ok = status ~= 0 && (v.UserRead || (~isnan(v.GroupRead) && v.GroupRead) || (~isnan(v.OtherRead) && v.OtherRead));
end

end

%!assert (is_readable('is_readable.m'))
%!assert (!is_readable(''))
