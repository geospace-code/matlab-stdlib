classdef TestNetCDF < matlab.unittest.TestCase

properties
TestData
end

methods (TestMethodSetup)

function setup_file(tc)

A0 = 42.;
A1 = [42.; 43.];
A2 = magic(4);
A3 = A2(:,1:3,1);
A3(:,:,2) = 2*A3;
A4(:,:,:,5) = A3;
utf0 = 'Hello There 😄';
utf1 = [utf0; "☎"];
utf2 = [utf0, "☎"; "📞", "👋"];

tc.TestData.A0 = A0;
tc.TestData.A1 = A1;
tc.TestData.A2 = A2;
tc.TestData.A3 = A3;
tc.TestData.A4 = A4;
tc.TestData.utf0 = utf0;
tc.TestData.utf1 = utf1;
tc.TestData.utf2 = utf2;

basic = tempname + ".nc";
tc.TestData.basic = basic;

% create test data first, so that parallel tests works
stdlib.ncsave(basic, 'A0', A0)
stdlib.ncsave(basic, 'A1', A1)
stdlib.ncsave(basic, 'A2', A2, "dims", {'x2', size(A2,1), 'y2', size(A2,2)})
stdlib.ncsave(basic, 'A3', A3, "dims", {'x3', size(A3,1), 'y3', size(A3,2), 'z3', size(A3,3)})
stdlib.ncsave(basic, 'A4', A4, "dims", {'x4', size(A4,1), 'y4', size(A4,2), 'z4', size(A4,3), 'w4', size(A4,4)})

if ~verLessThan('matlab', '9.11')
  stdlib.ncsave(basic, "utf0", utf0)
  stdlib.ncsave(basic, "utf1", utf1)
  stdlib.ncsave(basic, "utf2", utf2)
end

stdlib.ncsave(basic, '/t/x', 12)
stdlib.ncsave(basic, '/t/y', 13)
stdlib.ncsave(basic, '/j/a/b', 6)

tc.assumeTrue(isfile(basic))
end
end


methods (TestMethodTeardown)
function cleanup(tc)
delete(tc.TestData.basic)
end
end


methods (Test)
function test_get_variables(tc)
basic = tc.TestData.basic;

k = ["A0", "A1", "A2", "A3", "A4"];
if ~verLessThan('matlab', '9.11')
  k = [k, ["utf0", "utf1", "utf2"]];
end

tc.verifyEqual(sort(stdlib.ncvariables(basic)), k)

% 1-level group
v = stdlib.ncvariables(basic, "/t");
tc.verifyEqual(sort(v), ["x", "y"])

% traversal
tc.verifyEmpty(stdlib.ncvariables(basic, "/j") )

tc.verifyEqual(stdlib.ncvariables(basic, "/j/a") , "b")
end


function test_exists(tc)

basic = tc.TestData.basic;

tc.verifyEmpty(stdlib.ncexists(basic, string.empty))

e = stdlib.ncexists(basic, "");

tc.verifyTrue(isscalar(e))
tc.verifyFalse(e)

e = stdlib.ncexists(basic, ["A1", "oops"]);
tc.verifyTrue(isvector(e))
tc.verifyEqual(e, [true, false])

e = stdlib.ncexists(basic, {'A0', 'A1', 'A2', 'A3', 'A4'});
tc.verifyTrue(all(e))
end


function test_size(tc)
basic = tc.TestData.basic;

tc.verifyEmpty(stdlib.ncndims(basic, string.empty))
tc.verifyEmpty(stdlib.ncndims(basic, ""))

r = stdlib.ncndims(basic, 'A0');
s = stdlib.ncsize(basic, 'A0');
tc.verifyEmpty(s)
tc.verifyEqual(r, 0)

r = stdlib.ncndims(basic, 'A1');
s = stdlib.ncsize(basic, 'A1');
tc.verifyTrue(isscalar(s))
tc.verifyEqual(s, 2)
tc.verifyEqual(r, 1)

r = stdlib.ncndims(basic, 'A2');
s = stdlib.ncsize(basic, 'A2');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,4])
tc.verifyEqual(r, 2)

r = stdlib.ncndims(basic, 'A3');
s = stdlib.ncsize(basic, 'A3');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2])
tc.verifyEqual(r, 3)

r = stdlib.ncndims(basic, 'A4');
s = stdlib.ncsize(basic, 'A4');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2,5])
tc.verifyEqual(r, 4)
end

function test_size_string(tc)
basic = tc.TestData.basic;

tc.assumeFalse(verLessThan('matlab', '9.11'), "NetCDF4 string required Matlab >= R2021b")

r = stdlib.ncndims(basic, 'utf0');
s = stdlib.ncsize(basic, 'utf0');
tc.verifyEmpty(s)
tc.verifyEqual(r, 0)

r = stdlib.ncndims(basic, 'utf1');
s = stdlib.ncsize(basic, 'utf1');
tc.verifyEqual(s, 2)
tc.verifyEqual(r, 1)

r = stdlib.ncndims(basic, 'utf2');
s = stdlib.ncsize(basic, 'utf2');
tc.verifyEqual(s, [2, 2])
tc.verifyEqual(r, 2)
end


function test_read(tc)
basic = tc.TestData.basic;

s = ncread(basic, 'A0');
tc.verifyTrue(isscalar(s))
tc.verifyEqual(s, 42)

s = ncread(basic, 'A1');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, tc.TestData.A1)

s = ncread(basic, 'A2');
tc.verifyTrue(ismatrix(s))
tc.verifyEqual(s, tc.TestData.A2)

s = ncread(basic, 'A3');
tc.verifyEqual(ndims(s), 3)
tc.verifyEqual(s, tc.TestData.A3)

s = ncread(basic, 'A4');
tc.verifyEqual(ndims(s), 4)
tc.verifyEqual(s, tc.TestData.A4)
end

function test_read_string(tc)
basic = tc.TestData.basic;

tc.assumeFalse(verLessThan('matlab', '9.11'), "NetCDF4 string required Matlab >= R2021b")

s = ncread(basic, 'utf0');
tc.verifyTrue(isstring(s))
tc.verifyEqual(s, string(tc.TestData.utf0))

s = ncread(basic, 'utf1');
tc.verifyTrue(isstring(s))
tc.verifyEqual(s, tc.TestData.utf1)

s = ncread(basic, 'utf2');
tc.verifyTrue(isstring(s))
tc.verifyEqual(s, tc.TestData.utf2)
end


function test_coerce(tc)
basic = tc.TestData.basic;

for type = ["single", "double", ...
            "int8", "int16", "int32", "int64", ...
            "uint8", "uint16", "uint32", "uint64"]

  stdlib.ncsave(basic, type, 0, "type", type)

  tc.verifyClass(ncread(basic, type), type)
end

end


function test_rewrite(tc)
basic = tc.TestData.basic;

stdlib.ncsave(basic, "A2", 3*magic(4))

tc.assumeTrue(isfile(basic))
tc.verifyEqual(ncread(basic, 'A2'), 3*magic(4))
end

function test_name_only(tc)
[~,name] = fileparts(tempname);
tc.assumeFalse(isfile(name))

stdlib.ncsave(name, "/A0", 42);
delete(name)
end


function test_real_only(tc)
basic = tc.TestData.basic;

tc.verifyError(@() stdlib.ncsave(basic, "bad_imag", 1j), 'MATLAB:validators:mustBeReal')
tc.verifyError(@() stdlib.ncsave(basic, "", 0), 'MATLAB:validators:mustBeNonzeroLengthText')
end

end

end
