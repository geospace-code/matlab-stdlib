function fsize = h5size(file, variable)
% get size (shape) of an HDF5 dataset
%
% filename: HDF5 filename
% variable: name of variable inside HDF5 file
%
% fsize: vector of variable size per dimension
arguments
  file (1,1) string
  variable (1,1) string
end

file = expanduser(file);
if ~isfile(file)
  error('hdf5nc:h5size:fileNotFound', "%s does not exist", file)
end

fsize = h5info(file, variable).Dataspace.Size;

end
