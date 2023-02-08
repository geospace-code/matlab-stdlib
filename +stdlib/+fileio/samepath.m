function issame = samepath(path1, path2)

arguments
  path1 string {mustBeScalarOrEmpty}
  path2 string {mustBeScalarOrEmpty}
end

issame = stdlib.fileio.absolute_path(path1) == stdlib.fileio.absolute_path(path2);

end
