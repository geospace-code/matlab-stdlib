classdef TestSame < StdlibPath

properties
file = 'same.txt'
end

properties (TestParameter)
p = {...
{'..', './..'}, ...
{'same.txt', './same.txt'}}

backend = {'python', 'java', 'shell', 'native'}
end


methods(TestClassSetup)
function w_dirs(tc)
tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
tc.assertTrue(stdlib.touch(tc.file))
end
end


methods(Test)

function test_samepath(tc, p, backend)
[r, b] = stdlib.samepath(p{:}, backend);

if ismember(backend, stdlib.Backend().select('samepath'))
  tc.assertMatches(b, backend)
  tc.verifyClass(r, 'logical')
  tc.verifyTrue(r, [p{1} ' ' p{2}])
else
  tc.assertEqual(r, missing)
end
end


function test_samepath_cwd(tc, backend)
r = stdlib.samepath('.', pwd(), backend);
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
