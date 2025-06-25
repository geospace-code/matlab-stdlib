%% INODE filesystem inode of path
% requires: java
% Windows always returns 0, Unix returns inode number.

function i = inode(path)
arguments
  path {mustBeTextScalar}
end

i = [];

if stdlib.exists(path)
  if stdlib.isoctave()
    [s, err] = stat(path);
    if err == 0
      i = s.ino;
    end
  else
    i = java.nio.file.Files.getAttribute(javaPathObject(path), "unix:ino", javaLinkOption());
  end
else
  i = [];
end

end
