function exists = h5exists(filename, varname)
% check if variable exists in HDF5 file
%
% filename: HDF5 filename
% varname: name of variable inside HDF5 file
%
% exists: boolean

narginchk(2,2)
validateattributes(filename, {'char'}, {'vector'}, 1)
validateattributes(varname, {'char'}, {'vector'}, 2)

exists = any(strcmp(h5variables(filename), varname(2:end)));

end % function
