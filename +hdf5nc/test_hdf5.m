function tests = test_hdf5
tests = functiontests(localfunctions);
end

function setupOnce(tc)
import hdf5nc.h5save

A0 = 42.;
A1 = [42.; 43.];
A2 = magic(4);
A3 = A2(:,1:3,1);
A3(:,:,2) = 2*A3;
A4(:,:,:,5) = A3;

tc.TestData.A0 = A0;
tc.TestData.A1 = A1;
tc.TestData.A2 = A2;
tc.TestData.A3 = A3;
tc.TestData.A4 = A4;

basic = tempname + ".h5";
tc.TestData.basic = basic;
% create test data first, so that parallel tests works
h5save(basic, '/A0', A0)
h5save(basic, '/A1', A1)
h5save(basic, '/A2', A2)
h5save(basic, '/A3', A3, "size", size(A3))
h5save(basic, '/A4', A4)
end


function test_auto_chunk_size(tc)

assertEqual(tc, hdf5nc.auto_chunk_size([1500,2500,1000,500,100]), [12,20,8,8,2], '5D chunk fail')
assertEqual(tc, hdf5nc.auto_chunk_size([15,250,100]), [2,32,25], '3D chunk fail')
assertEqual(tc, hdf5nc.auto_chunk_size([15,250]), [15,250], '2D small chunk fail')

end


function test_get_variables(tc)
vars = hdf5nc.h5variables(tc.TestData.basic);
assertEqual(tc, sort(vars), ["A0", "A1", "A2", "A3", "A4"], 'missing variables')
end


function test_exists(tc)
e0 = hdf5nc.h5exists(tc.TestData.basic, '/A3');
assert(isscalar(e0))
assertTrue(tc, e0, 'A3 exists')

assertFalse(tc, hdf5nc.h5exists(tc.TestData.basic, '/oops'), 'oops not exist')

e1 = hdf5nc.h5exists(tc.TestData.basic, ["A3", "oops"]);
assert(isrow(e1))
assertEqual(tc, e1, [true, false], 'h5exists array')
end


function test_size(tc)
import hdf5nc.h5size
basic = tc.TestData.basic;

s = h5size(basic, '/A0');
assert(isscalar(s))
assertEqual(tc, s, 1, 'A0 shape')

s = h5size(basic, '/A1');
assert(isscalar(s))
assertEqual(tc, s, 2, 'A1 shape')

s = h5size(basic, '/A2');
assert(isvector(s))
assertEqual(tc, s, [4,4], 'A2 shape')

s = h5size(basic, '/A3');
assert(isvector(s))
assertEqual(tc, s, [4,3,2], 'A3 shape')

s = h5size(basic, '/A4');
assert(isvector(s))
assertEqual(tc, s, [4,3,2,5], 'A4 shape')
end


function test_read(tc)
basic = tc.TestData.basic;
s = h5read(basic, '/A0');
assert(isscalar(s))
assertEqual(tc, s, 42, 'A0 read')

s = h5read(basic, '/A1');
assert(isvector(s))
assertEqual(tc, s, tc.TestData.A1, 'A1 read')

s = h5read(basic, '/A2');
assert(ismatrix(s))
assertEqual(tc, s, tc.TestData.A2, 'A2 read')

s = h5read(tc.TestData.basic, '/A3');
assert(ndims(s)==3)
assertEqual(tc, s, tc.TestData.A3, 'A3 read')

s = h5read(tc.TestData.basic, '/A4');
assert(ndims(s)==4)
assertEqual(tc, s, tc.TestData.A4, 'A4 read')
end


function test_coerce(tc)

basic = tc.TestData.basic;
A0 = tc.TestData.A0;

hdf5nc.h5save(basic, '/int32', A0, "type", 'int32')
hdf5nc.h5save(basic, '/int64', A0, "type", 'int64')
hdf5nc.h5save(basic, '/float32', A0, "type", 'float32')

assertClass(tc, h5read(basic, '/int32'), 'int32', 'int32')
assertClass(tc, h5read(basic, '/int64'), 'int64', 'int64')
assertClass(tc, h5read(basic, '/float32'), 'single', 'float32')
end


function test_rewrite(tc)
hdf5nc.h5save(tc.TestData.basic, '/A2', 3*magic(4))
assertEqual(tc, h5read(tc.TestData.basic, '/A2'), 3*magic(4), 'rewrite 2D fail')
end
