function fsize = h5size(filename, variable)
% get size (shape) of an HDF5 dataset
%
% filename: HDF5 filename
% variable: name of variable inside HDF5 file
%
% fsize: vector of variable size per dimension

narginchk(2,2)
validateattributes(variable, {'char'}, {'vector'}, 2)

finf = h5info(expanduser(filename), variable);
fsize = finf.Dataspace.Size;

end % function
