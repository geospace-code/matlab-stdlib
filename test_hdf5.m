% test our custom high-level HDF5 interface

A0 = 42.;
A1 = [42.; 43.];
A2 = magic(4);
A3 = A2(:,1:3,1);
A3(:,:,2) = 2*A3;
A4(:,:,:,5) = A3;

basic = fullfile(tempdir, 'basic.h5');
if is_file(basic), delete(basic), end

%% test_write_basic
h5save(basic, '/A0', A0)
h5save(basic, '/A1', A1)
h5save(basic, '/A2', A2)
h5save(basic, '/A3', A3)
h5save(basic, '/A4', A4)
%% test_get_variables
vars = h5variables(basic);
assert(isequal(sort(vars),{'A0', 'A1', 'A2', 'A3', 'A4'}), 'missing variables')
%% test_exists
assert(h5exists(basic, '/A3'), 'A3 exists')
assert(~h5exists(basic, '/oops'), 'oops not exist')
%% test_size
s = h5size(basic, '/A0');
assert(isscalar(s) && s==1, 'A0 shape')

s = h5size(basic, '/A1');
assert(isscalar(s) && s==2, 'A1 shape')

s = h5size(basic, '/A2');
assert(isvector(s) && isequal(s, [4,4]), 'A2 shape')

s = h5size(basic, '/A3');
assert(isvector(s) && isequal(s, [4,3,2]), 'A3 shape')

s = h5size(basic, '/A4');
assert(isvector(s) && isequal(s, [4,3,2,5]), 'A4 shape')
%% test_read
s = h5read(basic, '/A0');
assert(isscalar(s) && s==42, 'A0 read')

s = h5read(basic, '/A1');
assert(isvector(s) && isequal(s, A1), 'A1 read')

s = h5read(basic, '/A2');
assert(ismatrix(s) && isequal(s, A2), 'A2 read')

s = h5read(basic, '/A3');
assert(ndims(s)==3 && isequal(s, A3), 'A3 read')

s = h5read(basic, '/A4');
assert(ndims(s)==4 && isequal(s, A4), 'A4 read')
%% test_coerce
h5save(basic, '/int32', A0, [], 'int32')
h5save(basic, '/int64', A0, [], 'int64')
h5save(basic, '/float32', A0, [], 'float32')

assert(isa(h5read(basic, '/int32'), 'int32'), 'int32')
assert(isa(h5read(basic, '/int64'), 'int64'), 'int64')
assert(isa(h5read(basic, '/float32'), 'single'), 'float32')
%% test_rewrite
h5save(basic, '/A2', 3*magic(4))
assert(isequal(h5read(basic, '/A2'), 3*magic(4)), 'rewrite 2D fail')