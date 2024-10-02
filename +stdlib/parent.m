function p = parent(p, use_java)
% PARENT parent directory of path
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  % java is about 10x slower than intrinsic
  p = java.io.File(p).getParent();
else
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
