function fsize = ncsize(file, variable)
% get size (shape) of a NetCDF4 variable
%
% filename: NetCDF4 filename
% variable: name of variable inside file
%
% fsize: vector of variable size per dimension
arguments
  file string
  variable string
end

assert(length(file)<2, "one file at a time")
assert(length(variable)<2, "one variable at a time")

fsize = [];

file = expanduser(file);

if isempty(file) || isempty(variable)
  return
end

if ~isfile(file)
  error("hdf5nc:ncsize:fileNotFound", "%s not found.", file)
end

fsize = ncinfo(file, variable).Size;

end
