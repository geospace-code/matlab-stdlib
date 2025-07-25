%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(p)
arguments
  p {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = stdlib.python.inode(p);
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  opt = javaMethod("values", "java.nio.file.LinkOption");
  i = javaMethod("getAttribute", "java.nio.file.Files", javaPathObject(p), "unix:ino", opt);
end

if isempty(i)
  i = stdlib.sys.inode(p);
end

end

%!assert(inode(pwd) >= 0);
%!assert(isempty(inode(tempname())));
