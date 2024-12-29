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
% * opts.type: class of variable e.g. int32, float32

function ncsave(filename, varname, A, opts)
arguments
  filename (1,1) string
  varname (1,1) string
  A {mustBeNonempty}
  opts.dims cell = {}
  opts.type (1,1) string = ""
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

if isfile(filename)
  if stdlib.ncexists(filename, varname)
    stdlib.ncsave_exist(filename, varname, A, sizeA)
  else
    stdlib.ncsave_new(filename, varname, A, sizeA, opts.dims, opts.compressLevel)
  end
else
  stdlib.ncsave_new(filename, varname, A, sizeA, opts.dims, opts.compressLevel)
end

end

%!testif 0
