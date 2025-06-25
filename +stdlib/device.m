%% DEVICE filesystem device index of path
% requires: java
% Windows always returns 0, Unix returns device number.

function i = device(path)
arguments
  path {mustBeTextScalar}
end

if stdlib.exists(path)
  if stdlib.isoctave()
    [s, err] = stat(path);
    if err == 0
      i = s.dev;
    end
  else
    i = java.nio.file.Files.getAttribute(javaPathObject(path), "unix:dev", javaLinkOption());
  end
else
  i = [];
end

end
