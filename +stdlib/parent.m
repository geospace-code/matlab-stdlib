%% PARENT parent directory of path
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()

function p = parent(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  % java is about 10x slower than intrinsic
  p = java.io.File(p).getParent();
else
  p = stdlib.posix(p);
  % drop duplicated slashes in the parent path
  p = regexprep(p, "//+", "/");

  if ispc && any(strlength(p) == [2,3]) && strlength(stdlib.root_name(p))
    % 2 or 3 char drive letter
    p = stdlib.root(p);
    return
  end
  % have to drop_slash on input to get expected parent path
  p = strip(stdlib.posix(p), "right", "/");
  j = strfind(p, "/");
  if isempty(j)
    p = "";
  else
    p = extractBefore(p, j(end));
  end
end

if p == ""
  p = ".";
end

p = stdlib.posix(p);

end
