classdef TestDisk < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", "", "not-exist"}
end

methods(Test, TestTags = "mex")

function test_mex_disk_available(tc)
import matlab.unittest.constraints.IsFile
tc.assertThat(fileparts(mfilename("fullpath")) + "/../+stdlib/disk_available." + mexext, IsFile)
end

function test_mex_disk_capacity(tc)
import matlab.unittest.constraints.IsFile
tc.assertThat(fileparts(mfilename("fullpath")) + "/../+stdlib/disk_capacity." + mexext, IsFile)
end

end

methods (Test, TestTags = "java")

function test_disk_available(tc, Ps)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_available(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_available(Ps), zero)
end
end

function test_disk_capacity(tc, Ps)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_capacity(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_capacity(Ps), zero)
end
end

end
end
