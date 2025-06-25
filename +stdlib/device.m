%% DEVICE filesystem device index of path
% requires: java
% Windows always returns 0, Unix returns device number.

function i = device(path)
arguments
  path {mustBeTextScalar}
end

i = [];

if stdlib.exists(path)
  if stdlib.isoctave()
    [s, err] = stat(path);
    if err == 0
      i = s.dev;
    end
  elseif stdlib.has_java() && stdlib.java_api() >= 11
    % Java 1.8 is buggy in some corner cases, so we require at least 11.
    i = java.nio.file.Files.getAttribute(javaPathObject(path), "unix:dev", javaLinkOption());
  end
end

end

%!assert(device(pwd) >= 0);
%!assert(isempty(device(tempname())));
