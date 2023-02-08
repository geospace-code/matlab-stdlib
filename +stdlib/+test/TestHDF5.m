classdef TestHDF5 < matlab.unittest.TestCase

properties
TestData
end

properties (TestParameter)
str = {"string", 'char'}
end


methods (TestMethodSetup)

function setup_file(tc)
import stdlib.h5save
import matlab.unittest.constraints.IsFile

A0 = 42.;
A1 = [42.; 43.];
A2 = magic(4);
A3 = A2(:,1:3,1);
A3(:,:,2) = 2*A3;
A4(:,:,:,5) = A3;
utf = 'Hello There 😄';
utf2 = [utf; "☎"];

tc.TestData.A0 = A0;
tc.TestData.A1 = A1;
tc.TestData.A2 = A2;
tc.TestData.A3 = A3;
tc.TestData.A4 = A4;
tc.TestData.utf = utf;
tc.TestData.utf2 = utf2;

basic = tempname + ".h5";
tc.TestData.basic = basic;

% create test data first, so that parallel tests works
h5save(basic, '/A0', A0)
h5save(basic, '/A1', A1)
h5save(basic, '/A2', A2)
h5save(basic, '/A3', A3, "size", size(A3))
h5save(basic, '/A4', A4)

h5save(basic, "/utf", utf)
h5save(basic, "/utf2", utf2)

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
import stdlib.hdf5nc.auto_chunk_size

tc.verifyEqual(auto_chunk_size([1500,2500,1000,500,100]), [12,20,8,8,2])
tc.verifyEqual(auto_chunk_size([15,250,100]), [2,32,25])
tc.verifyEqual(auto_chunk_size([15,250]), [15,250])
end


function test_get_variables(tc)
import stdlib.h5variables

basic = tc.TestData.basic;

v = h5variables(basic);
k = ["A0", "A1", "A2", "A3", "A4", "utf", "utf2"];
tc.verifyEqual(sort(v), k)

% 1-level group
v = h5variables(basic, "/t");
tc.verifyEqual(sort(v), ["x", "y"])

% traversal
tc.verifyEmpty( h5variables(basic, "/j") )

tc.verifyEqual( h5variables(basic, "/j/a") , "b")

end


function test_exists(tc)
import stdlib.h5exists
basic = tc.TestData.basic;

tc.verifyEmpty(h5exists(basic, string.empty))

e = h5exists(basic, "");

tc.verifyTrue(isscalar(e))
tc.verifyFalse(e)

vars = {'A0', 'A1', 'A2', 'A3', 'A4', '/A0'};

e = h5exists(basic, vars);
tc.verifyTrue(isvector(e))
tc.verifyTrue(all(e))

% vector
e = h5exists(basic, ["/A1", "oops"]);
tc.verifyTrue(isrow(e))
tc.verifyEqual(e, [true, false])
end


function test_size(tc)

import stdlib.h5ndims
basic = tc.TestData.basic;

tc.verifyEmpty(h5ndims(basic, string.empty))
tc.verifyEmpty(h5ndims(basic, ""))

r = h5ndims(basic, '/A0');
s = stdlib.h5size(basic, '/A0');
tc.verifyEmpty(s)
tc.verifyEqual(r, 0)

r = h5ndims(basic, '/A1');
s = stdlib.h5size(basic, '/A1');
tc.verifyTrue(isscalar(s))
tc.verifyEqual(s, 2)
tc.verifyEqual(r, 1)

r = h5ndims(basic, '/A2');
s = stdlib.h5size(basic, '/A2');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,4])
tc.verifyEqual(r, 2)

r = h5ndims(basic, '/A3');
s = stdlib.h5size(basic, '/A3');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2])
tc.verifyEqual(r, 3)

r = h5ndims(basic, '/A4');
s = stdlib.h5size(basic, '/A4');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2,5])
tc.verifyEqual(r, 4)

r = h5ndims(basic, '/utf');
s = stdlib.h5size(basic, '/utf');
tc.verifyEmpty(s)
tc.verifyEqual(r, 0)

r = h5ndims(basic, '/utf2');
s = stdlib.h5size(basic, '/utf2');
tc.verifyEqual(s, 2)
tc.verifyEqual(r, 1)
end


function test_read(tc)
basic = tc.TestData.basic;

s = h5read(basic, '/A0');
tc.verifyTrue(isscalar(s))
tc.verifyEqual(s, tc.TestData.A0)

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

s = h5read(basic, '/utf');
tc.verifyTrue(ischar(s))
tc.verifyEqual(s, tc.TestData.utf)

s = h5read(basic, '/utf2');
tc.verifyTrue(isstring(s))
tc.verifyEqual(s, tc.TestData.utf2)

end


function test_shape(tc)

basic = tc.TestData.basic;

stdlib.h5save(basic, "/vector1", 34, "size", 1)
s = stdlib.h5size(basic, '/vector1');
tc.verifyEqual(s, 1);

stdlib.h5save(basic, "/scalar", 34, "size", 0)
s = stdlib.h5size(basic, '/scalar');
tc.verifyEmpty(s);

end


function test_coerce(tc)
import matlab.unittest.constraints.IsFile
basic = tc.TestData.basic;

for type = ["single", "double", ...
            "int8", "int16", "int32", "int64", ...
            "uint8", "uint16", "uint32", "uint64"]

  stdlib.h5save(basic, type, 0, "type",type)

  tc.verifyClass(h5read(basic, "/"+type), type)
end

end


function test_rewrite(tc)
import matlab.unittest.constraints.IsFile
basic = tc.TestData.basic;

stdlib.h5save(basic, '/A2', 3*magic(4))

tc.assumeThat(basic, IsFile)
tc.verifyEqual(h5read(basic, '/A2'), 3*magic(4))
end

function test_int8(tc)
import stdlib.h5save
basic = tc.TestData.basic;

h5save(basic, "/i1", int8(127))

a = h5read(basic, "/i1");
tc.verifyEqual(a, int8(127))

% test rewrite
h5save(basic, "/i1", int8(-128))

a = h5read(basic, "/i1");
tc.verifyEqual(a, int8(-128))

% test int8 array
h5save(basic, "/Ai1", int8([1, 2]))
a = h5read(basic, "/Ai1");
tc.verifyEqual(a, int8([1;2]))
end

function test_string(tc, str)

basic = tc.TestData.basic;

stdlib.h5save(basic, "/"+str, str)

a = h5read(basic, "/"+str);
tc.verifyEqual(a, char(str))

% test rewrite
stdlib.h5save(basic, "/"+str, str+"hi")

a = h5read(basic, "/"+str);
tc.verifyEqual(a, char(str+"hi"))
end

function test_name_only(tc)

[~,name] = fileparts(tempname);
tc.assumeFalse(isfile(name))

stdlib.h5save(name, "/A0", 42);
delete(name)
end


function test_real_only(tc)
basic = tc.TestData.basic;

tc.verifyError(@() stdlib.h5save(basic, "/bad_imag", 1j), 'MATLAB:validators:mustBeReal')
tc.verifyError(@() stdlib.h5save(basic, "", 0), 'MATLAB:validators:mustBeNonzeroLengthText')
tc.verifyError(@() stdlib.h5variables(basic, '/nothere'), 'MATLAB:imagesci:h5info:unableToFind')
end

end

end
