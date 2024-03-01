function n = normalize(p)
% normalize(p) remove redundant elements of path p
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Path.html#normalize()
arguments
  p string {mustBeScalarOrEmpty}
end

n = p;
if isempty(p)
  return
end

n = stdlib.fileio.posix(java.io.File(stdlib.fileio.expanduser(n)).toPath().normalize());

end
