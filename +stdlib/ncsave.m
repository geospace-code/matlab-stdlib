function ncsave(filename, varname, A, opts)

arguments
  filename (1,1) string
  varname (1,1) string
  A {mustBeNonempty}
  opts.dims cell = {}
  opts.type string {mustBeScalarOrEmpty} = string.empty
end

stdlib.hdf5nc.ncsave(filename, varname, A, dims=opts.dims, type=opts.type)
end
