function n = normalize(p)
% normalize(p) remove redundant elements of path p
arguments
  p string {mustBeScalarOrEmpty}
end

n = p;
if isempty(p)
  return
end

n = string(java.io.File(stdlib.fileio.expanduser(n)).toPath().normalize());

end
