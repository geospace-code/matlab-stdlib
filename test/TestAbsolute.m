classdef TestAbsolute < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
p1 = {'', "", "hi", "./hi", "../hi"};
p2 = {{'', ''}, {'', ""}, {"", ''}, {"", ""}, {"", "hi"}, {"hi", ""}, {'there', "hi"}};
end


methods(TestClassSetup)
function set_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  tc.td = tempname();
  mkdir(tc.td);
else
  tc.td = tc.createTemporaryFolder();
end
tc.applyFixture(matlab.unittest.fixtures.CurrentFolderFixture(tc.td))
end
end

methods(TestClassTeardown)
function remove_temp_wd(tc)
if isMATLABReleaseOlderThan('R2022a')
  rmdir(tc.td, 's');
end
end
end


methods(Test, TestTags="pure")

function test_absolute1arg(tc, p1)

r = tc.td;

if strlength(p1)
  r = fullfile(r, p1);
end

if isstring(p1)
  r = string(r);
end

tc.verifyEqual(stdlib.absolute(p1), r)
end


function test_absolute2arg(tc, p2)

r = tc.td;

if strlength(p2{2})
  r = fullfile(r, p2{2});
end

if strlength(p2{1})
  r = fullfile(r, p2{1});
end

if isstring(p2{1}) || isstring(p2{2})
  r = string(r);
end

tc.verifyEqual(stdlib.absolute(p2{1}, p2{2}), r)
end

end

end
