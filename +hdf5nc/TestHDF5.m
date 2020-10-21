classdef TestHDF5 < matlab.unittest.TestCase

properties
TestData
end

properties (TestParameter)
type = {'single', 'double', 'int32', 'int64'};
end


methods (TestClassSetup)

function setup_file(tc)
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
end


methods (TestClassTeardown)
function cleanup(tc)
delete(tc.TestData.basic)
end
end


methods (Test)

function test_auto_chunk_size(tc)
tc.verifyEqual(auto_chunk_size([1500,2500,1000,500,100]), [12,20,8,8,2])
tc.verifyEqual(auto_chunk_size([15,250,100]), [2,32,25])
tc.verifyEqual(auto_chunk_size([15,250]), [15,250])
end


function test_get_variables(tc)
import hdf5nc.h5variables

vars = h5variables(tc.TestData.basic);
tc.verifyEqual(sort(vars), ["A0", "A1", "A2", "A3", "A4"])
end


function test_exists(tc)
import hdf5nc.h5exists
import matlab.unittest.constraints.IsScalar

e0 = h5exists(tc.TestData.basic, '/A3');
tc.verifyThat(e0, IsScalar)
tc.verifyTrue(e0)

tc.verifyFalse(h5exists(tc.TestData.basic, '/oops'))

e1 = h5exists(tc.TestData.basic, ["A3", "oops"]);
tc.verifyTrue(isrow(e1))
tc.verifyEqual(e1, [true, false])
end


function test_size(tc)
import hdf5nc.h5size
import matlab.unittest.constraints.IsScalar
basic = tc.TestData.basic;

s = h5size(basic, '/A0');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 1)

s = h5size(basic, '/A1');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 2)

s = h5size(basic, '/A2');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,4])

s = h5size(basic, '/A3');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2])

s = h5size(basic, '/A4');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2,5])
end


function test_read(tc)
import matlab.unittest.constraints.IsScalar
import matlab.unittest.constraints.IsFile
basic = tc.TestData.basic;
tc.assumeThat(basic, IsFile)

s = h5read(basic, '/A0');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 42)

s = h5read(basic, '/A1');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, tc.TestData.A1)

s = h5read(basic, '/A2');
tc.verifyTrue(ismatrix(s))
tc.verifyEqual(s, tc.TestData.A2)

s = h5read(basic, '/A3');
tc.verifyEqual(ndims(s), 3)
tc.verifyEqual(s, tc.TestData.A3)

s = h5read(basic, '/A4');
tc.verifyEqual(ndims(s), 4)
tc.verifyEqual(s, tc.TestData.A4)
end


function test_coerce(tc, type)
import hdf5nc.h5save
import matlab.unittest.constraints.IsFile
basic = tc.TestData.basic;

vn = "/" + type;

h5save(basic, vn, 0, "type", type)

tc.assumeThat(basic, IsFile)

tc.verifyClass(h5read(basic, vn), type)
end


function test_rewrite(tc)
import hdf5nc.h5save
import matlab.unittest.constraints.IsFile
basic = tc.TestData.basic;

h5save(basic, '/A2', 3*magic(4))

tc.assumeThat(basic, IsFile)
tc.verifyEqual(h5read(basic, '/A2'), 3*magic(4))
end

function test_string(tc)
import hdf5nc.h5save
basic = tc.TestData.basic;

h5save(basic, "/a_string", "hello")
h5save(basic, "/a_char", 'there')

astr = h5read(basic, "/a_string");
achar = h5read(basic, "/a_char");
tc.verifyEqual(astr, "hello")
tc.verifyEqual(achar, "there")
end

function test_real_only(tc)
import hdf5nc.h5save
tc.verifyError(@() h5save(tc.TestData.basic, "/bad_imag", 1j), 'MATLAB:validators:mustBeReal')
end

end

end
