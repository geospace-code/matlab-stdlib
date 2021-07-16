function fsize = h5size(file, variable)
% get size (shape) of an HDF5 dataset
%
% filename: HDF5 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension
arguments
  file (1,1) string {mustBeNonzeroLengthText}
  variable (1,1) string {mustBeNonzeroLengthText}
end

import stdlib.fileio.expanduser

file = expanduser(file);

assert(isfile(file), "%s not found", file)

dsi = h5info(file, variable).Dataspace;
if dsi.Type == "scalar"
  fsize = 1;
else
  fsize = dsi.Size;
end

end
