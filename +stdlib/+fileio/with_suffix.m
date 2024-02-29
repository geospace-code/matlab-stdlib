function filename = with_suffix(filename, suffix)

arguments
  filename string {mustBeScalarOrEmpty}
  suffix (1,1) string
end

[direc, name, ext] = fileparts(filename);
if ext ~= suffix
  filename = stdlib.fileio.join(direc, name + suffix);
end

end
