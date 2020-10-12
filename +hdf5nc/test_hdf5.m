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

function teardownOnce(tc)
delete(tc.TestData.basic)
end


function test_auto_chunk_size(tc)

tc.assertEqual(hdf5nc.auto_chunk_size([1500,2500,1000,500,100]), [12,20,8,8,2], '5D chunk fail')
tc.assertEqual(hdf5nc.auto_chunk_size([15,250,100]), [2,32,25], '3D chunk fail')
tc.assertEqual(hdf5nc.auto_chunk_size([15,250]), [15,250], '2D small chunk fail')

end


function test_get_variables(tc)
vars = hdf5nc.h5variables(tc.TestData.basic);
tc.assertEqual(sort(vars), ["A0", "A1", "A2", "A3", "A4"], 'missing variables')
end


function test_exists(tc)
e0 = hdf5nc.h5exists(tc.TestData.basic, '/A3');
tc.assertTrue(isscalar(e0))
tc.assertTrue(e0, 'A3 exists')

tc.assertFalse(hdf5nc.h5exists(tc.TestData.basic, '/oops'), 'oops not exist')

e1 = hdf5nc.h5exists(tc.TestData.basic, ["A3", "oops"]);
tc.assertTrue(isrow(e1))
tc.assertEqual(e1, [true, false], 'h5exists array')
end


function test_size(tc)
import hdf5nc.h5size
basic = tc.TestData.basic;

s = h5size(basic, '/A0');
tc.assertTrue(isscalar(s))
tc.assertEqual(s, 1, 'A0 shape')

s = h5size(basic, '/A1');
tc.assertTrue(isscalar(s))
tc.assertEqual(s, 2, 'A1 shape')

s = h5size(basic, '/A2');
tc.assertTrue(isvector(s))
tc.assertEqual(s, [4,4], 'A2 shape')

s = h5size(basic, '/A3');
tc.assertTrue(isvector(s))
tc.assertEqual(s, [4,3,2], 'A3 shape')

s = h5size(basic, '/A4');
tc.assertTrue(isvector(s))
tc.assertEqual(s, [4,3,2,5], 'A4 shape')
end


function test_read(tc)
basic = tc.TestData.basic;
s = h5read(basic, '/A0');
tc.assertTrue(isscalar(s))
tc.assertEqual(s, 42, 'A0 read')

s = h5read(basic, '/A1');
tc.assertTrue(isvector(s))
tc.assertEqual(s, tc.TestData.A1, 'A1 read')

s = h5read(basic, '/A2');
tc.assertTrue(ismatrix(s))
tc.assertEqual(s, tc.TestData.A2, 'A2 read')

s = h5read(tc.TestData.basic, '/A3');
tc.assertEqual(ndims(s), 3)
tc.assertEqual(s, tc.TestData.A3, 'A3 read')

s = h5read(tc.TestData.basic, '/A4');
tc.assertEqual(ndims(s), 4)
tc.assertEqual(s, tc.TestData.A4, 'A4 read')
end


function test_coerce(tc)

basic = tc.TestData.basic;

hdf5nc.h5save(basic, '/int32', 0, "type", 'int32')
hdf5nc.h5save(basic, '/int64', 0, "type", 'int64')
hdf5nc.h5save(basic, '/float32', 0, "type", 'float32')

tc.assertClass(h5read(basic, '/int32'), 'int32', 'int32')
tc.assertClass(h5read(basic, '/int64'), 'int64', 'int64')
tc.assertClass(h5read(basic, '/float32'), 'single', 'float32')
end


function test_rewrite(tc)
hdf5nc.h5save(tc.TestData.basic, '/A2', 3*magic(4))
tc.assertEqual(h5read(tc.TestData.basic, '/A2'), 3*magic(4), 'rewrite 2D fail')
end

function test_string(tc)
hdf5nc.h5save(tc.TestData.basic, "/a_string", "hello")
hdf5nc.h5save(tc.TestData.basic, "/a_char", 'there')

astr = h5read(tc.TestData.basic, "/a_string");
achar = h5read(tc.TestData.basic, "/a_char");
tc.assertEqual(astr, "hello")
tc.assertEqual(achar, "there")
tc.assertClass(astr, "string")
tc.assertClass(achar, "string")
end
