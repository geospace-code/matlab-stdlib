function isabs = is_absolute_path(apath)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#isAbsolute()
arguments
  apath string {mustBeScalarOrEmpty}
end

if isempty(apath)
  isabs = logical.empty();
  return
end

% expanduser() here to work like C++ filesystem::path::is_absolute()
isabs = java.io.File(stdlib.fileio.expanduser(apath)).isAbsolute();

end
