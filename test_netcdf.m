% test our custom high-level NetCDF4 interface

A0 = 42.;
A1 = [42.; 43.];
A2 = magic(4);
A3 = A2(:,1:3,1);
A3(:,:,2) = 2*A3;
A4(:,:,:,5) = A3;

basic = [tempname, '.nc'];

if isoctave
  pkg('load','netcdf')
end
%% test_write_basic
ncsave(basic, 'A0', A0)
ncsave(basic, 'A1', A1)
ncsave(basic, 'A2', A2, {'x2', size(A2,1), 'y2', size(A2,2)})
ncsave(basic, 'A3', A3, {'x3', size(A3,1), 'y3', size(A3,2), 'z3', size(A3,3)})
ncsave(basic, 'A4', A4, {'x4', size(A4,1), 'y4', size(A4,2), 'z4', size(A4,3), 'w4', size(A4,4)})
%% test_get_variables
vars = ncvariables(basic);
assert(isequal(sort(vars),{'A0', 'A1', 'A2', 'A3', 'A4'}), 'missing variables')
%% test_exists
assert(ncexists(basic, 'A3'), 'A3 exists')
assert(~ncexists(basic, 'oops'), 'oops not exist')
%% test_size
s = ncsize(basic, 'A0');
assert(isscalar(s) && s==1, 'A0 shape')

s = ncsize(basic, 'A1');
assert(isscalar(s) && s==2, 'A1 shape')

s = ncsize(basic, 'A2');
assert(isvector(s) && isequal(s, [4,4]), 'A2 shape')

s = ncsize(basic, 'A3');
assert(isvector(s) && isequal(s, [4,3,2]), 'A3 shape')

s = ncsize(basic, 'A4');
assert(isvector(s) && isequal(s, [4,3,2,5]), 'A4 shape')
%% test_read
s = ncread(basic, '/A0');
assert(isscalar(s) && s==42, 'A0 read')

s = ncread(basic, '/A1');
assert(isvector(s) && isequal(s, A1), 'A1 read')

s = ncread(basic, '/A2');
assert(ismatrix(s) && isequal(s, A2), 'A2 read')

s = ncread(basic, '/A3');
assert(ndims(s)==3 && isequal(s, A3), 'A3 read')

s = ncread(basic, '/A4');
assert(ndims(s)==4 && isequal(s, A4), 'A4 read')
%% test_coerce
ncsave(basic, 'int32', A0, [], 'int32')
ncsave(basic, 'int64', A0, [], 'int64')
ncsave(basic, 'float32', A0, [], 'float32')

assert(isa(ncread(basic, 'int32'), 'int32'), 'int32')
assert(isa(ncread(basic, 'int64'), 'int64'), 'int64')
assert(isa(ncread(basic, 'float32'), 'single'), 'float32')
%% test_rewrite
ncsave(basic, 'A2', 3*magic(4))
assert(isequal(ncread(basic, 'A2'), 3*magic(4)), 'rewrite 2D fail')
