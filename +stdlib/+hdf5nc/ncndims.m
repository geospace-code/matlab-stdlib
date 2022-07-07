function frank = ncndims(file, variable)
% get number of dimensions of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file

arguments
  file (1,1) string {mustBeNonzeroLengthText}
  variable (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);

dsi = ncinfo(file, variable);
if isempty(dsi.Dimensions)
  frank = 0;
else
  frank = length(dsi.Size);
end

end
