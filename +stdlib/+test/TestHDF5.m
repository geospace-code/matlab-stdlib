classdef TestHDF5 < matlab.unittest.TestCase

properties
TestData
end

properties (TestParameter)
str = {"string", 'char'}
end


methods (TestMethodSetup)

function setup_file(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.constraints.IsFile
fixture = tc.applyFixture(TemporaryFolderFixture);

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

tc.TestData.basic = fullfile(fixture.Folder, "basic.h5");
bf = tc.TestData.basic;

% create test data first, so that parallel tests works
stdlib.h5save(bf, '/A0', A0)
stdlib.h5save(bf, '/A1', A1)
stdlib.h5save(bf, '/A2', A2)
stdlib.h5save(bf, '/A3', A3, "size", size(A3))
stdlib.h5save(bf, '/A4', A4)

stdlib.h5save(bf, "/utf", utf)
stdlib.h5save(bf, "/utf2", utf2)

stdlib.h5save(bf, '/t/x', 12)
stdlib.h5save(bf, '/t/y', 13)
stdlib.h5save(bf, '/j/a/b', 6)

tc.assumeThat(bf, IsFile)
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

basic = tc.TestData.basic;

v = stdlib.h5variables(basic);
k = ["A0", "A1", "A2", "A3", "A4", "utf", "utf2"];
tc.verifyEqual(sort(v), k)

% 1-level group
v = stdlib.h5variables(basic, "/t");
tc.verifyEqual(sort(v), ["x", "y"])

% traversal
tc.verifyEmpty(stdlib.h5variables(basic, "/j") )

tc.verifyEqual(stdlib.h5variables(basic, "/j/a") , "b")

end


function test_exists(tc)
import matlab.unittest.constraints.IsScalar
basic = tc.TestData.basic;

tc.verifyEmpty(stdlib.h5exists(basic, string.empty))

e = stdlib.h5exists(basic, "");

tc.verifyThat(e, IsScalar)
tc.verifyFalse(e)

vars = {'A0', 'A1', 'A2', 'A3', 'A4', '/A0'};

e = stdlib.h5exists(basic, vars);
tc.verifyTrue(isvector(e))
tc.verifyTrue(all(e))

% vector
e = stdlib.h5exists(basic, ["/A1", "oops"]);
tc.verifyTrue(isrow(e))
tc.verifyEqual(e, [true, false])
end


function test_size(tc)
import matlab.unittest.constraints.IsScalar
basic = tc.TestData.basic;

tc.verifyEmpty(stdlib.h5ndims(basic, string.empty))
tc.verifyEmpty(stdlib.h5ndims(basic, ""))

r = stdlib.h5ndims(basic, '/A0');
s = stdlib.h5size(basic, '/A0');
tc.verifyEmpty(s)
tc.verifyEqual(r, 0)

r = stdlib.h5ndims(basic, '/A1');
s = stdlib.h5size(basic, '/A1');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 2)
tc.verifyEqual(r, 1)

r = stdlib.h5ndims(basic, '/A2');
s = stdlib.h5size(basic, '/A2');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,4])
tc.verifyEqual(r, 2)

r = stdlib.h5ndims(basic, '/A3');
s = stdlib.h5size(basic, '/A3');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2])
tc.verifyEqual(r, 3)

r = stdlib.h5ndims(basic, '/A4');
s = stdlib.h5size(basic, '/A4');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2,5])
tc.verifyEqual(r, 4)

r = stdlib.h5ndims(basic, '/utf');
s = stdlib.h5size(basic, '/utf');
tc.verifyEmpty(s)
tc.verifyEqual(r, 0)

r = stdlib.h5ndims(basic, '/utf2');
s = stdlib.h5size(basic, '/utf2');
tc.verifyEqual(s, 2)
tc.verifyEqual(r, 1)
end


function test_read(tc)
import matlab.unittest.constraints.IsScalar
import matlab.unittest.constraints.IsOfClass
basic = tc.TestData.basic;

s = h5read(basic, '/A0');
tc.verifyThat(s, IsScalar)
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
tc.verifyThat(s, IsOfClass('string'))
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
basic = tc.TestData.basic;

stdlib.h5save(basic, "/i1", int8(127))

a = h5read(basic, "/i1");
tc.verifyEqual(a, int8(127))

% test rewrite
stdlib.h5save(basic, "/i1", int8(-128))

a = h5read(basic, "/i1");
tc.verifyEqual(a, int8(-128))

% test int8 array
stdlib.h5save(basic, "/Ai1", int8([1, 2]))
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


function test_real_only(tc)
basic = tc.TestData.basic;

tc.verifyError(@() stdlib.h5save(basic, "/bad_imag", 1j), 'MATLAB:validators:mustBeReal')
tc.verifyError(@() stdlib.h5save(basic, "", 0), 'MATLAB:validators:mustBeNonzeroLengthText')
tc.verifyError(@() stdlib.h5variables(basic, '/nothere'), 'MATLAB:imagesci:h5info:unableToFind')
end

end

end
