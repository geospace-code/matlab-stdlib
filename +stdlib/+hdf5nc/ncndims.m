function frank = ncndims(file, variable)

arguments
  file (1,1) string {mustBeFile}
  variable string {mustBeScalarOrEmpty}
end

if isempty(variable) || strlength(variable) == 0
  frank = [];
  return
end

dsi = ncinfo(file, variable);
if isempty(dsi.Dimensions)
  frank = 0;
else
  frank = length(dsi.Size);
end

end
