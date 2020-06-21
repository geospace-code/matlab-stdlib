function exists = h5exists(filename, varname)
% check if variable exists in HDF5 file
%
% filename: HDF5 filename
% varname: name of variable inside HDF5 file
%
% exists: boolean

narginchk(2,2)
validateattributes(varname, {'char'}, {'vector'}, 2)

filename = expanduser(filename);

vars = {};
if is_file(filename)
  vars = h5variables(filename);
end

exists = any(strcmp(vars, varname(2:end)));

end % function
