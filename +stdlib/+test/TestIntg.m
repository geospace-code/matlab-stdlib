classdef TestIntg < matlab.unittest.TestCase

methods (Test)

function test_checkRAM(tc)
import stdlib.sys.checkRAM

pe = pyenv;
tc.assumeNotEmpty(pe.Version)

tc.assertTrue(islogical(checkRAM(1)))
end

function test_diskfree(tc)
  import stdlib.sys.diskfree
tc.assertTrue(isnumeric(diskfree('~')))
tc.assertTrue(diskfree('~') > 0, 'diskfree')
end

function test_memory(tc)
import stdlib.sys.memfree

pe = pyenv;
tc.assumeNotEmpty(pe.Version)
tc.assertTrue(isnumeric(memfree))
end

end
end
