function issame = samepath(path1, path2)

arguments
  path1 string {mustBeScalarOrEmpty}
  path2 string {mustBeScalarOrEmpty}
end

if isempty(path1) || isempty(path2)
   issame = logical.empty;
   return
end

% absolute_path because unlike c++ filesystem, isSameFile does not
% canonicalize first
p1 = java.io.File(stdlib.fileio.absolute_path(path1)).toPath();
p2 = java.io.File(stdlib.fileio.absolute_path(path2)).toPath();

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
