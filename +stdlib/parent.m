function p = parent(p, use_java)
% PARENT parent directory of path
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getParent()
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  % java is about 10x slower than intrinsic
  p = string(java.io.File(p).getParent());
else
  % have to drop_slash on input to get expected parent path
  p = strip(p, "right", "/");
  [p, ~, ~] = fileparts(p);
end

if isempty(p) || strlength(p) == 0
  p = ".";
end

p = stdlib.posix(p);

end
