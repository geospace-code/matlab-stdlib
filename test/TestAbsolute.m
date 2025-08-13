classdef (TestTags = {'R2019b', 'impure'}) ...
    TestAbsolute < matlab.unittest.TestCase

properties (TestParameter)
p1 = {'', "", "hi", "./hi", "../hi"};
p2 = {{'', ""}, {'', ""}, {"", ""}, {"", ""}, {"", "hi"}, {"hi", ""}, {'there', "hi"}};
end


methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)

  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods(Test)

function test_absolute1arg(tc, p1)

r = pwd();

if strlength(p1)
  r = fullfile(r, p1);
end

rabs = stdlib.absolute(p1);

tc.verifyClass(rabs, 'string')
tc.verifyEqual(rabs, string(r))
end


function test_absolute2arg(tc, p2)

r = pwd();

if strlength(p2{2})
  r = fullfile(r, p2{2});
end

if strlength(p2{1})
  r = fullfile(r, p2{1});
end

rabs = stdlib.absolute(p2{1}, p2{2});

tc.verifyClass(rabs, 'string')
tc.verifyEqual(rabs, string(r))
end


function test_absolute_array(tc)

in = ["", "hi"];
r = stdlib.absolute(in);

tc.verifyEqual(r, [pwd(), fullfile(pwd(), "hi")])

end

end

end
