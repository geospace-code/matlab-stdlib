function fsize = h5size(file, variable)
% get size (shape) of an HDF5 dataset
%
% filename: HDF5 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension
arguments
  file string
  variable string
end

import stdlib.fileio.expanduser

assert(length(file)<2, "one file at a time")
assert(length(variable)<2, "one variable at a time")

fsize = [];

file = expanduser(file);

if isempty(file) || isempty(variable)
  return
end

if ~isfile(file)
  error("hdf5nc:h5size:fileNotFound", "%s not found.", file)
end

dsi = h5info(file, variable).Dataspace;
if dsi.Type == "scalar"
  fsize = 1;
else
  fsize = dsi.Size;
end

end
