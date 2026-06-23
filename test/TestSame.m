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

backend = {'python', 'java', 'perl', 'shell', 'native'}
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
tc.assertMatches(b, backend)

if ismember(backend, stdlib.Backend().select('samepath'))
  tc.verifyClass(r, 'logical')
  tc.verifyTrue(r, [p{1} ' ' p{2}])
else
  tc.assertEqual(r, missing)
end
end


function test_samepath_cwd(tc, backend)
r = stdlib.samepath('.', tc.cwd, backend);
if ismember(backend, stdlib.Backend().select('samepath'))
  tc.verifyTrue(r)
else
  tc.verifyEqual(r, missing)
end
end


function test_samepath_notexist(tc)
tc.verifyError(@() stdlib.samepath(tempname(), tempname()), 'MATLAB:validators:mustBeFileOrFolder')
end

end

end
