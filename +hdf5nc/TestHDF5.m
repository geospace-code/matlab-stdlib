classdef TestHDF5 < matlab.unittest.TestCase

properties
TestData
end

properties (TestParameter)
type = {'single', 'double', 'int32', 'int64'}
vars = {'A0', 'A1', 'A2', 'A3', 'A4'}
str = {"string", 'char'}
end


methods (TestMethodSetup)

function setup_file(tc)
import hdf5nc.h5save
import matlab.unittest.constraints.IsFile

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

h5save(basic, '/t/x', 12)
h5save(basic, '/t/y', 13)
h5save(basic, '/j/a/b', 6)

tc.assumeThat(basic, IsFile)
end
end


methods (TestMethodTeardown)
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
basic = tc.TestData.basic;

v = h5variables(basic);
tc.verifyEqual(sort(v), ["A0", "A1", "A2", "A3", "A4"])

[v1,g] = h5variables(basic);
tc.verifyEqual(v,v1)
tc.verifyEqual(sort(g), ["/j", "/t"])

% 1-level group
[v, g] = h5variables(basic, "/t");
tc.verifyEqual(sort(v), ["x", "y"])
tc.verifyEmpty(g)

% traversal
[v, g] = h5variables(basic, "/j");
tc.verifyEmpty(v)
tc.verifyEqual(g, "/j/a")

[v, g] = h5variables(basic, "/j/a");
tc.verifyEqual(v, "b")
tc.verifyEmpty(g)

end


function test_exists(tc, vars)
import hdf5nc.h5exists
import matlab.unittest.constraints.IsScalar
basic = tc.TestData.basic;

e = h5exists(basic, "/" + vars);
tc.verifyThat(e, IsScalar)
tc.verifyTrue(e)

% vector
e = h5exists(basic, [vars, "oops", ""]);
tc.verifyTrue(isrow(e))
tc.verifyEqual(e, [true, false, false])

% empty
e = h5exists(basic, string.empty);
tc.verifyEmpty(e)
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

% empty
tc.verifyError(@() h5size(basic, string.empty), 'MATLAB:validation:IncompatibleSize')
end


function test_read(tc)
import matlab.unittest.constraints.IsScalar
basic = tc.TestData.basic;

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

function test_string(tc, str)
import hdf5nc.h5save
basic = tc.TestData.basic;

h5save(basic, "/"+str, str)

a = h5read(basic, "/"+str);
tc.verifyEqual(a, string(str))
end

function test_file_missing(tc)

tc.verifyError(@() hdf5nc.h5exists(tempname,""), 'hdf5nc:h5variables:fileNotFound')
tc.verifyError(@() hdf5nc.h5variables(tempname), 'hdf5nc:h5variables:fileNotFound')
tc.verifyError(@() hdf5nc.h5size(tempname,""), 'hdf5nc:h5size:fileNotFound')
[~,badname] = fileparts(tempname);
tc.verifyError(@() hdf5nc.h5save(badname,"",0), 'hdf5nc:h5save:fileNotFound')
end

function test_real_only(tc)
import hdf5nc.h5save
basic = tc.TestData.basic;

tc.verifyError(@() h5save(basic, "/bad_imag", 1j), 'MATLAB:validators:mustBeReal')
tc.verifyError(@() h5save(basic, "", 0), 'MATLAB:expectedNonempty')
end

end

end
