classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017b', 'impure'}) ...
    TestSame < matlab.unittest.TestCase

properties (TestParameter)
p_same = {...
{".", pwd()}, ...
{"..", "./.."}, ...
{"..", pwd() + "/.."}, ...
{pwd(), pwd() + "/."}}

backend = {'python', 'java', 'perl', 'sys', 'native'}
end


methods(Test)

function test_samepath(tc, p_same, backend)
[r, b] = stdlib.samepath(p_same{:}, backend);
tc.assertEqual(char(b), backend)
tc.verifyClass(r, 'logical')

if ismember(backend, stdlib.Backend().select('samepath'))
  tc.verifyTrue(r)
else
  tc.assertEmpty(r)
end
end


function test_samepath_notexist(tc, backend)

t = tempname();
r1 = stdlib.samepath("", "", backend);
r2 = stdlib.samepath(t, t, backend);

if ismember(backend, stdlib.Backend().select('samepath'))
  tc.verifyFalse(r1)
  tc.verifyFalse(r2)
else
  tc.assertEmpty(r1)
  tc.assertEmpty(r2)
end
end

end

end
