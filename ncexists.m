function exists = ncexists(filename, varname)
% check if variable exists in NetCDF4 file
%
% filename: NetCDF4 filename
% varname: name of variable inside file
%
% exists: boolean

narginchk(2,2)
validateattributes(filename, {'char'}, {'vector'}, 1)
validateattributes(varname, {'char'}, {'vector'}, 2)

exists = any(strcmp(ncvariables(filename), varname));

end % function
