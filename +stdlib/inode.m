%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(p)
arguments
  p {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = uint64(int64(py.os.stat(p).st_ino)); % int64 first is for Matlab <= R2022a
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  opt = javaMethod("values", "java.nio.file.LinkOption");
  i = javaMethod("getAttribute", "java.nio.file.Files", javaPathObject(p), "unix:ino", opt);
elseif stdlib.isoctave()
  [s, err] = stat(p);
  if err == 0
    i = s.ino;
  end
end

end

%!assert(inode(pwd) >= 0);
%!assert(isempty(inode(tempname())));
