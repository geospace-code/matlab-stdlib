%% NCSAVE save data to NetCDF4 file
% create or append to data file
%
% parent folder (file directory) must already exist
%
%%% Inputs
% * filename: data filename
% * varname: variable name to save
% * A: data to write
% * opts.dims: name and size of dimensions
% * opts.type: class of variable e.g. int32, single

function ncsave(filename, varname, A, opts)
arguments
  filename {mustBeTextScalar}
  varname {mustBeTextScalar}
  A {mustBeNonempty}
  opts.dims cell = {}
  opts.type {mustBeTextScalar} = ''
  opts.compressLevel (1,1) double {mustBeInteger,mustBeNonnegative} = 0
end

if isnumeric(A)
  mustBeReal(A)
end

% avoid creating confusing file ./~/a.nc
filename = stdlib.expanduser(filename);

% coerce if needed
A = coerce_ds(A, opts.type);

if isscalar(A)
  sizeA = 1;
else
  if isempty(opts.dims)
    error("For non-scalar NetCDF variables, the dimenions must be defined as a cell array")
  end
  for i = 2:2:length(opts.dims)
    sizeA(i/2) = opts.dims{i}; %#ok<AGROW>
  end
end

try
  stdlib.ncsave_exist(filename, varname, A, sizeA)
catch e
  if ismember(e.identifier, ["MATLAB:imagesci:netcdf:unableToOpenFileforRead", "MATLAB:imagesci:netcdf:unknownLocation"])
    stdlib.ncsave_new(filename, varname, A, sizeA, opts.dims, opts.compressLevel)
  else
    rethrow(e)
  end
end

end

%!testif 0
