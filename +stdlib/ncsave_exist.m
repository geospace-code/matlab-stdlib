%% NCSAVE_EXIST save a variable to a NetCDF4 existing dataset
% normally users will use ncsave() instead of this function

function ncsave_exist(filename, varname, A, sizeA)
arguments
  filename {mustBeTextScalar}
  varname {mustBeTextScalar}
  A {mustBeNonempty}
  sizeA (1,:) {mustBePositive, mustBeInteger}
end

diskshape = stdlib.ncsize(filename, varname);

if all(diskshape == sizeA)
  ncwrite(filename, varname, A)
elseif all(diskshape == fliplr(sizeA))
  ncwrite(filename, varname, A.')
else
  error('ncsave:value_error', ['shape of ',varname,': ', int2str(sizeA), ' does not match existing NetCDF4 shape ', int2str(diskshape)])
end

end

%!test
%! if !isempty(pkg('list', 'netcdf'))
%! pkg load netcdf
%! fn = tempname();
%! ds = 'a';
%! a = [1,2];
%! b = [3,4];
%! ncsave_new(fn, ds, a, size(a), {"x", 1, "y", 2}, 0)
%! ncsave_exist(fn, ds, b, size(b))
%! assert(ncread(fn, ds), b)
%! delete(fn)
%! endif
