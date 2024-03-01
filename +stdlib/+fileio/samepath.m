function issame = samepath(path1, path2)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#isSameFile(java.nio.file.Path,java.nio.file.Path)
arguments
  path1 string {mustBeScalarOrEmpty}
  path2 string {mustBeScalarOrEmpty}
end

if isempty(path1) || isempty(path2)
   issame = logical.empty;
   return
end

% java.nio.file.Files needs CANONICAL -- not just absolute path
p1 = java.io.File(stdlib.fileio.canonical(path1)).toPath();
p2 = java.io.File(stdlib.fileio.canonical(path2)).toPath();

try
  issame = java.nio.file.Files.isSameFile(p1, p2);
catch e
  if e.identifier == "MATLAB:Java:GenericException" && contains(e.message, "NoSuchFileException")
    issame = false;
  else
    rethrow(e)
  end
end

end
