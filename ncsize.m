function fsize = ncsize(filename, varname)
% get size (shape) of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension

narginchk(2,2)
validateattributes(filename, {'char'}, {'vector'}, 1)
validateattributes(varname, {'char'}, {'vector'}, 2)

vinf = ncinfo(expanduser(filename), varname);
fsize = vinf.Size;

% Octave compatibility
if isempty(fsize)
  fsize = 1;
end

end
