function frank = h5ndims(file, variable)

arguments
  file (1,1) string {mustBeFile}
  variable string {mustBeScalarOrEmpty}
end

if isempty(variable) || strlength(variable) == 0
  frank = [];
  return
end

dsi = h5info(stdlib.fileio.expanduser(file), variable).Dataspace;
if dsi.Type == "scalar"
  frank = 0;
else
  frank = length(dsi.Size);
end

end
