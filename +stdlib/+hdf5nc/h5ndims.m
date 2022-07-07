function frank = h5ndims(file, variable)
% get number of dimensions of an HDF5 dataset
%
% filename: HDF5 filename
% variable: name of variable inside file
%
arguments
  file (1,1) string {mustBeNonzeroLengthText}
  variable (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);

dsi = h5info(file, variable).Dataspace;
if dsi.Type == "scalar"
  frank = 0;
else
  frank = length(dsi.Size);
end

end
