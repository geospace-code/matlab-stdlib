function frank = ncndims(file, variable)
% get number of dimensions of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file

arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

dsi = ncinfo(stdlib.fileio.expanduser(file), variable);
if isempty(dsi.Dimensions)
  frank = 0;
else
  frank = length(dsi.Size);
end

end
