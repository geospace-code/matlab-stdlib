%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(path)
arguments
  path {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = uint64(py.pathlib.Path(path).stat().st_ino);
elseif isunix() && stdlib.java_api() >= 11
  % Java 1.8 is buggy in some corner cases, so we require at least 11.
  opt = javaMethod("values", "java.nio.file.LinkOption");
  i = javaMethod("getAttribute", "java.nio.file.Files", javaPathObject(path), "unix:ino", opt);
elseif stdlib.isoctave()
  [s, err] = stat(path);
  if err == 0
    i = s.ino;
  end
end

end

%!assert(inode(pwd) >= 0);
%!assert(isempty(inode(tempname())));
