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

backend
not_backend
end


methods (TestParameterDefinition, Static)
function [backend, not_backend] = setup_backend()
  rpath = fileparts(fileparts(mfilename('fullpath')));
  addpath(rpath)

  not_backend = {};
  backend = {};
  for b = ["python", "java", "perl", "sys", "native"]
    if isempty(stdlib.samepath(rpath, rpath, b))
      not_backend{end+1} = char(b); %#ok<AGROW>
    else
      backend{end+1} = char(b); %#ok<AGROW>
    end
  end

  rmpath(rpath)
end
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
tc.assertEqual(b, backend)
tc.verifyClass(r, 'logical')

tc.verifyTrue(r, [p{1} ' ' p{2}])
end


function test_missing_backend(tc, not_backend)
[r, b] = stdlib.samepath('.', '.', not_backend);
tc.verifyEqual(b, not_backend)
tc.verifyEmpty(r)
end


function test_samepath_cwd(tc, backend)
r = stdlib.samepath('.', tc.cwd, backend);
tc.verifyTrue(r)
end


function test_samepath_notexist(tc, backend)

t = tempname();
r1 = stdlib.samepath('', '', backend);
r2 = stdlib.samepath(t, t, backend);

tc.verifyFalse(r1)
tc.verifyFalse(r2)

end

end

end
