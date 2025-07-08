classdef TestHDF5 < matlab.unittest.TestCase

properties
file
A0
A1
A2
A3
A4
utf
utf2
end

properties (TestParameter)
str = {"string", 'char'}
type = {"single", "double", ...
            "int8", "int16", "int32", "int64", ...
            "uint8", "uint16", "uint32", "uint64", "string"}
end

methods(TestClassSetup)
function setup_file(tc)

td = tc.createTemporaryFolder();

tc.A0 = 42.;
tc.A1 = [42.; 43.];
tc.A2 = magic(4);
tc.A3 = tc.A2(:,1:3,1);
tc.A3(:,:,2) = 2*tc.A3;
tc.A4(:,:,:,5) = tc.A3;
tc.utf = 'Hello There 😄';
tc.utf2 = [tc.utf; "☎"];

tc.file = td + "/basic.h5";

% create test data first, so that parallel tests works
stdlib.h5save(tc.file, '/A0', tc.A0)

tc.assertTrue(stdlib.is_hdf5(tc.file))

stdlib.h5save(tc.file, '/A1', tc.A1)
stdlib.h5save(tc.file, '/A2', tc.A2)
stdlib.h5save(tc.file, '/A3', tc.A3, size=size(tc.A3))
stdlib.h5save(tc.file, '/A4', tc.A4)

stdlib.h5save(tc.file, "/utf", tc.utf)
stdlib.h5save(tc.file, "/utf2", tc.utf2)

stdlib.h5save(tc.file, '/t/x', 12)
stdlib.h5save(tc.file, '/t/y', 13)
stdlib.h5save(tc.file, '/j/a/b', 6)

tc.assertThat(tc.file, matlab.unittest.constraints.IsFile)
end
end


methods (Test, TestTags="hdf5")

function test_auto_chunk_size(tc)

tc.verifyEqual(stdlib.auto_chunk_size([1500,2500,1000,500,100]), [12,20,8,8,2])
tc.verifyEqual(stdlib.auto_chunk_size([15,250,100]), [2,32,25])
tc.verifyEqual(stdlib.auto_chunk_size([15,250]), [15,250])
end


function test_get_variables(tc)

v = stdlib.h5variables(tc.file);
k = ["A0", "A1", "A2", "A3", "A4", "utf", "utf2"];

tc.verifyEqual(sort(v), k)

% 1-level group
v = stdlib.h5variables(tc.file, "/t");
tc.verifyEqual(sort(v), ["x", "y"])

% traversal
tc.verifyEmpty(stdlib.h5variables(tc.file, "/j") )

tc.verifyEqual(stdlib.h5variables(tc.file, "/j/a") , "b")

end


function test_exists(tc)
import matlab.unittest.constraints.IsScalar

e = stdlib.h5exists(tc.file, "/A0");

tc.verifyThat(e, IsScalar)
tc.verifyTrue(e);

end


function test_size(tc)
import matlab.unittest.constraints.IsScalar

s = stdlib.h5size(tc.file, '/A0');
tc.verifyEmpty(s)

s = stdlib.h5size(tc.file, '/A1');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 2)

s = stdlib.h5size(tc.file, '/A2');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,4])

s = stdlib.h5size(tc.file, '/A3');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2])

s = stdlib.h5size(tc.file, '/A4');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2,5])

s = stdlib.h5size(tc.file, '/utf');
tc.verifyEmpty(s)

s = stdlib.h5size(tc.file, '/utf2');
tc.verifyEqual(s, 2)

end


function test_read(tc)
import matlab.unittest.constraints.IsScalar


s = h5read(tc.file, '/A0');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, tc.A0)

s = h5read(tc.file, '/A1');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, tc.A1)

s = h5read(tc.file, '/A2');
tc.verifyTrue(ismatrix(s))
tc.verifyEqual(s, tc.A2)

s = h5read(tc.file, '/A3');
tc.verifyEqual(ndims(s), 3)
tc.verifyEqual(s, tc.A3)

s = h5read(tc.file, '/A4');
tc.verifyEqual(ndims(s), 4)
tc.verifyEqual(s, tc.A4)

s = h5read(tc.file, '/utf');
tc.verifyTrue(ischar(s))
tc.verifyEqual(s, tc.utf)

s = h5read(tc.file, '/utf2');
tc.verifyClass(s, 'string')
tc.verifyEqual(s, tc.utf2)

end


function test_shape(tc)

stdlib.h5save(tc.file, "/vector1", 34, "size", 1)
s = stdlib.h5size(tc.file, '/vector1');
tc.verifyEqual(s, 1);

stdlib.h5save(tc.file, "/scalar", 34, "size", 0)
s = stdlib.h5size(tc.file, '/scalar');
tc.verifyEmpty(s);

end


function test_coerce(tc, type)

stdlib.h5save(tc.file, "/" + type, 0, "type", type)

switch type
case "string", vt = 'char';
otherwise, vt = type;
end

tc.verifyClass(h5read(tc.file, "/"+type), vt)

end


function test_rewrite(tc)

stdlib.h5save(tc.file, '/A2', 3*magic(4))

tc.verifyEqual(h5read(tc.file, '/A2'), 3*magic(4))
end

function test_int8(tc)

stdlib.h5save(tc.file, "/i1", int8(127))

a = h5read(tc.file, "/i1");
tc.verifyEqual(a, int8(127))

% test rewrite
stdlib.h5save(tc.file, "/i1", int8(-128))

a = h5read(tc.file, "/i1");
tc.verifyEqual(a, int8(-128))

% test int8 array
stdlib.h5save(tc.file, "/Ai1", int8([1, 2]))
a = h5read(tc.file, "/Ai1");
tc.verifyEqual(a, int8([1;2]))
end

function test_string(tc, str)

stdlib.h5save(tc.file, "/"+str, str)

a = h5read(tc.file, "/"+str);
tc.verifyEqual(a, char(str))

% test rewrite
stdlib.h5save(tc.file, "/"+str, str+"hi")

a = h5read(tc.file, "/"+str);
tc.verifyEqual(a, char(str+"hi"))
end


function test_real_only(tc)

tc.verifyError(@() stdlib.h5save(tc.file, "/bad_imag", 1j), 'MATLAB:validators:mustBeReal')
tc.verifyError(@() stdlib.h5variables(tc.file, '/nothere'), 'MATLAB:imagesci:h5info:unableToFind')
end

end

end
