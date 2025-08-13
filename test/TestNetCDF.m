classdef TestNetCDF < matlab.unittest.TestCase

properties
file
A0
A1
A2
A3
A4
utf0
utf1
utf2
end

methods (TestClassSetup)

function test_dirs(tc)
  pkg_path(tc)
end


function setup_file(tc)

tc.A0 = 42.;
tc.A1 = [42.; 43.];
tc.A2 = magic(4);
tc.A3 = tc.A2(:,1:3,1);
tc.A3(:,:,2) = 2*tc.A3;
tc.A4(:,:,:,5) = tc.A3;
tc.utf0 = 'Hello There 😄';
tc.utf1 = [tc.utf0; "☎"];
tc.utf2 = [tc.utf0, "☎"; "📞", "👋"];

td = createTempdir(tc);
tc.file = td + "/basic.nc";

% create test data first, so that parallel tests works
stdlib.ncsave(tc.file, 'A0', tc.A0)
stdlib.ncsave(tc.file, 'A1', tc.A1, "dims", {'x1', size(tc.A1,1)})
stdlib.ncsave(tc.file, 'A2', tc.A2, "dims", {'x2', size(tc.A2,1), 'y2', size(tc.A2,2)})
stdlib.ncsave(tc.file, 'A3', tc.A3, "dims", {'x3', size(tc.A3,1), 'y3', size(tc.A3,2), 'z3', size(tc.A3,3)})
stdlib.ncsave(tc.file, 'A4', tc.A4, "dims", {'x4', size(tc.A4,1), 'y4', size(tc.A4,2), 'z4', size(tc.A4,3), 'w4', size(tc.A4,4)})

if ~stdlib.matlabOlderThan('R2021b')
stdlib.ncsave(tc.file, "utf0", tc.utf0)
stdlib.ncsave(tc.file, "utf1", tc.utf1, "dims", {'s1', size(tc.utf1, 1)})
stdlib.ncsave(tc.file, "utf2", tc.utf2, "dims", {'s1', size(tc.utf2, 1), 't1', size(tc.utf2, 2)})
end

stdlib.ncsave(tc.file, '/t/x', 12)
stdlib.ncsave(tc.file, '/t/y', 13)
stdlib.ncsave(tc.file, '/j/a/b', 6)

tc.assertThat(tc.file, matlab.unittest.constraints.IsFile)
end
end


methods (Test, TestTags=["R2019b", "netcdf"])

function test_netcdf_version(tc)
tc.verifyTrue(stdlib.version_atleast(stdlib.nc_get_version(), "4.7"), "version unexpected")
end

function test_get_variables(tc)
k = ["A0", "A1", "A2", "A3", "A4"];

if ~stdlib.matlabOlderThan('R2021b')
  k = [k, ["utf0", "utf1", "utf2"]];
end

tc.verifyEqual(sort(stdlib.ncvariables(tc.file)), k)

% 1-level group
v = stdlib.ncvariables(tc.file, "/t");
tc.verifyEqual(sort(v), ["x", "y"])

% traversal
tc.verifyEmpty(stdlib.ncvariables(tc.file, "/j") )

tc.verifyEqual(stdlib.ncvariables(tc.file, "/j/a") , "b")
end


function test_exists(tc)
import matlab.unittest.constraints.IsScalar

tc.verifyTrue(stdlib.ncexists(tc.file, "A1"))
tc.verifyFalse(stdlib.ncexists(tc.file, "not-exist"))

end


function test_size(tc)
import matlab.unittest.constraints.IsScalar

s = stdlib.ncsize(tc.file, 'A0');
tc.verifyEmpty(s)

s = stdlib.ncsize(tc.file, 'A1');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 2)

s = stdlib.ncsize(tc.file, 'A2');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,4])

s = stdlib.ncsize(tc.file, 'A3');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2])

s = stdlib.ncsize(tc.file, 'A4');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, [4,3,2,5])

end


function test_read(tc)
import matlab.unittest.constraints.IsScalar


s = ncread(tc.file, 'A0');
tc.verifyThat(s, IsScalar)
tc.verifyEqual(s, 42)

s = ncread(tc.file, 'A1');
tc.verifyTrue(isvector(s))
tc.verifyEqual(s, tc.A1)

s = ncread(tc.file, 'A2');
tc.verifyTrue(ismatrix(s))
tc.verifyEqual(s, tc.A2)

s = ncread(tc.file, 'A3');
tc.verifyEqual(ndims(s), 3)
tc.verifyEqual(s, tc.A3)

s = ncread(tc.file, 'A4');
tc.verifyEqual(ndims(s), 4)
tc.verifyEqual(s, tc.A4)
end


function test_coerce(tc)

for type = ["single", "double", ...
            "int8", "int16", "int32", "int64", ...
            "uint8", "uint16", "uint32", "uint64"]

  stdlib.ncsave(tc.file, type, 0, "type", type)

  tc.verifyClass(ncread(tc.file, type), type)
end

end


function test_rewrite(tc)
tc.A2 = 3*magic(4);
stdlib.ncsave(tc.file, "A2", tc.A2, "dims", {'x2', size(tc.A2,1), 'y2', size(tc.A2,2)})

tc.verifyEqual(ncread(tc.file, 'A2'), 3*magic(4))
end


function test_real_only(tc)
tc.verifyError(@() stdlib.ncsave(tc.file, "bad_imag", 1j), 'MATLAB:validators:mustBeReal')
end

end


methods (Test, TestTags=["R2021b", "netcdf"])

function test_size_string(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2021b'), "NetCDF4 string requires Matlab >= R2021b")

s = stdlib.ncsize(tc.file, 'utf0');
tc.verifyEmpty(s)

s = stdlib.ncsize(tc.file, 'utf1');
tc.verifyEqual(s, 2)

s = stdlib.ncsize(tc.file, 'utf2');
tc.verifyEqual(s, [2, 2])
end


function test_read_string(tc)
tc.assumeFalse(stdlib.matlabOlderThan('R2021b'), "NetCDF4 string requires Matlab >= R2021b")

s = ncread(tc.file, 'utf0');
tc.verifyClass(s, 'string')
tc.verifyEqual(s, string(tc.utf0))

s = ncread(tc.file, 'utf1');
tc.verifyClass(s, 'string')
tc.verifyEqual(s, tc.utf1)

s = ncread(tc.file, 'utf2');
tc.verifyClass(s, 'string')
tc.verifyEqual(s, tc.utf2)
end

end


end
