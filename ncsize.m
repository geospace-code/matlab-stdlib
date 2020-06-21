function fsize = ncsize(filename, varname)
% get size (shape) of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension

narginchk(2,2)
validateattributes(varname, {'char'}, {'vector'}, 2)

vinf = ncinfo(filename, varname);
fsize = vinf.Size;

% Octave compatibility
if isempty(fsize)
  fsize = 1;
end

end