classdef TestDisk < matlab.unittest.TestCase

properties (TestParameter)
Ps = {".", "", "not-exist"}
end

methods (Test)

function test_disk_available(tc, Ps)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
tc.assumeEqual(exist("+stdlib/disk_available", "file"), 3)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_available(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_available(Ps), zero)
end
end

function test_disk_capacity(tc, Ps)
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(".."))
tc.assumeEqual(exist("+stdlib/disk_capacity", "file"), 3)

zero = uint64(0);

if stdlib.exists(Ps)
  tc.verifyGreaterThan(stdlib.disk_capacity(Ps), zero)
else
  tc.verifyEqual(stdlib.disk_capacity(Ps), zero)
end
end

end
end
