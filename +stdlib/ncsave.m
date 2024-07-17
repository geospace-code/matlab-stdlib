function ncsave(filename, varname, A, opts)

arguments
  filename (1,1) string {mustBeNonzeroLengthText}
  varname (1,1) string {mustBeNonzeroLengthText}
  A {mustBeNonempty}
  opts.dims cell = {}
  opts.type string {mustBeScalarOrEmpty} = string.empty
end

if isnumeric(A)
  mustBeReal(A)
end

% avoid creating confusing file ./~/foo.nc
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
    nc_exist_file(filename, varname, A, sizeA)
  else
    nc_new_file(filename, varname, A, sizeA, opts.dims)
  end
else
  nc_new_file(filename, varname, A, sizeA, opts.dims)
end

end
