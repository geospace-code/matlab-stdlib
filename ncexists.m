function exists = ncexists(filename, varname)
% check if variable exists in NetCDF4 file
%
% filename: NetCDF4 filename
% varname: name of variable inside file
%
% exists: boolean

narginchk(2,2)
validateattributes(varname, {'char'}, {'vector'}, 2)

filename = expanduser(filename);

vars = {};
if is_file(filename)
  vars = ncvariables(filename);
end

exists = any(strcmp(vars, varname));

end % function
