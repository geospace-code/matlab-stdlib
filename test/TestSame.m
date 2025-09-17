classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a'}) ...
    TestSame < matlab.unittest.TestCase

properties
file = 'same.txt'
cwd
end

properties (TestParameter)
p = {...
{'..', './..'}, ...
{'same.txt', './same.txt'}}

backend = {'python', 'java', 'perl', 'sys', 'native'}
end


methods(TestClassSetup)
function w_dirs(tc)
  f = matlab.unittest.fixtures.WorkingFolderFixture();
  tc.applyFixture(f);
  tc.cwd = f.Folder;
  tc.assertTrue(stdlib.touch(tc.file))
end
end


methods(Test)

function test_samepath(tc, p, backend)
[r, b] = stdlib.samepath(p{:}, backend);
tc.assertEqual(char(b), backend)
tc.verifyClass(r, 'logical')

if ismember(backend, stdlib.Backend().select('samepath'))
  tc.verifyTrue(r, [p{1} ' ' p{2}])
else
  tc.assertEmpty(r)
end
end


function test_samepath_cwd(tc, backend)
r = stdlib.samepath('.', tc.cwd, backend);
if ismember(backend, stdlib.Backend().select('samepath'))
  tc.verifyTrue(r)
else
  tc.verifyEmpty(r)
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
