function tests = test_netcdf
tests = functiontests(localfunctions);
end


function setupOnce(tc)
import hdf5nc.ncsave

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

basic = tempname + ".nc";
tc.TestData.basic = basic;

% create test data first, so that parallel tests works
ncsave(basic, 'A0', A0)
ncsave(basic, 'A1', A1)
ncsave(basic, 'A2', A2, "dims", {'x2', size(A2,1), 'y2', size(A2,2)})
ncsave(basic, 'A3', A3, "dims", {'x3', size(A3,1), 'y3', size(A3,2), 'z3', size(A3,3)})
ncsave(basic, 'A4', A4, "dims", {'x4', size(A4,1), 'y4', size(A4,2), 'z4', size(A4,3), 'w4', size(A4,4)})
end

function teardownOnce(tc)
delete(tc.TestData.basic)
end


function test_get_variables(tc)
import hdf5nc.ncvariables
vars = ncvariables(tc.TestData.basic);
tc.assertEqual(sort(vars), ["A0", "A1", "A2", "A3", "A4"], 'missing variables')
end


function test_exists(tc)
import hdf5nc.ncexists
e0 = ncexists(tc.TestData.basic, 'A3');
tc.assertTrue(isscalar(e0))
tc.assertTrue(e0, 'A3 exists')

assertFalse(tc, ncexists(tc.TestData.basic, '/oops'), 'oops not exist')

e1 = ncexists(tc.TestData.basic, ["A3", "oops"]);
tc.assertTrue(isrow(e1))
tc.assertEqual(e1, [true, false])
end

function test_size(tc)
import hdf5nc.ncsize
basic = tc.TestData.basic;

s = ncsize(basic, 'A0');
tc.assertTrue(isscalar(s))
tc.assertEqual(s, 1, 'A0 shape')

s = ncsize(basic, 'A1');
tc.assertTrue(isscalar(s))
tc.assertEqual(s, 2, 'A1 shape')

s = ncsize(basic, 'A2');
tc.assertTrue(isvector(s))
tc.assertEqual(s, [4,4], 'A2 shape')

s = ncsize(basic, 'A3');
tc.assertTrue(isvector(s))
tc.assertEqual(s, [4,3,2], 'A3 shape')

s = ncsize(basic, 'A4');
tc.assertTrue(isvector(s))
tc.assertEqual(s, [4,3,2,5], 'A4 shape')
end


function test_read(tc)
basic = tc.TestData.basic;

s = ncread(basic, '/A0');
tc.assertTrue(isscalar(s))
tc.assertEqual(s, 42, 'A0 read')

s = ncread(basic, '/A1');
tc.assertTrue(isvector(s))
tc.assertEqual(s, tc.TestData.A1, 'A1 read')

s = ncread(basic, '/A2');
tc.assertTrue(ismatrix(s))
tc.assertEqual(s, tc.TestData.A2, 'A2 read')

s = ncread(basic, '/A3');
tc.assertEqual(ndims(s), 3)
tc.assertEqual(s, tc.TestData.A3, 'A3 read')

s = ncread(basic, '/A4');
tc.assertEqual(ndims(s), 4)
tc.assertEqual(s, tc.TestData.A4, 'A4 read')
end


function test_coerce(tc)
import hdf5nc.ncsave

basic = tc.TestData.basic;

ncsave(basic, 'int32', 0, "type", 'int32')
ncsave(basic, 'int64', 0, "type", 'int64')
ncsave(basic, 'float32', 0, "type", 'float32')

tc.assertClass(h5read(basic, '/int32'), 'int32', 'int32')
tc.assertClass(h5read(basic, '/int64'), 'int64', 'int64')
tc.assertClass(h5read(basic, '/float32'), 'single', 'float32')
end

function test_rewrite(tc)
import hdf5nc.ncsave
ncsave(tc.TestData.basic, 'A2', 3*magic(4))
tc.assertEqual(ncread(tc.TestData.basic, 'A2'), 3*magic(4), 'rewrite 2D fail')
end

function test_no_char_string(tc)
import hdf5nc.ncsave
tc.assertError(@() ncsave(tc.TestData.basic, "/a_string", "hello"), 'MATLAB:validators:mustBeNumeric')

end

function test_real_only(tc)
import hdf5nc.ncsave
tc.assertError(@() ncsave(tc.TestData.basic, "/bad_imag", 1j), 'MATLAB:validators:mustBeReal')
end
