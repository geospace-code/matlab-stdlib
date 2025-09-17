classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a', 'pure'}) ...
    TestRoot < matlab.unittest.TestCase

properties (TestParameter)
p = init_root()
rn = init_rn()
rd = init_rd()
end


methods (Test)

function test_root(tc, p)
r = stdlib.root(p{1});
tc.assertClass(r, class(p{1}))
tc.verifyEqual(r, p{2}, "root(" + p{1} + ")")
end

function test_root_dir(tc, rd)
r = stdlib.root_dir(rd{1});
tc.assertClass(r, class(rd{1}))
tc.verifyEqual(r, rd{2}, "root_dir(" + rd{1} + ")")
end

function test_root_name(tc, rn)
r = stdlib.root_name(rn{1});
tc.assertClass(r, class(rn{1}))
tc.verifyEqual(r, rn{2})
end

end

end


function p = init_root()

p = {{"", ""}, ...
{"a/b", ""}, ...
{"./a/b", ""}, ...
{"/etc", "/"}, ...
{'/etc', '/'}, ...
{"c:", ""}, ...
{"c:/etc", ""}, ...
{'c:\etc', ''}};

if ispc()
  p{6}{2} = "c:";
  p{7}{2} = "c:/";
  p{8}{2} = 'c:\';
end

end


function p = init_rn()

p = init_root();

p{4}{2} = "";
p{5}{2} = '';

if ispc()
  p{6}{2} = "c:";
  p{7}{2} = "c:";
  p{8}{2} = 'c:';
end

end


function p = init_rd()

p = init_root();

if ispc()
  p{6}{2} = "";
  p{7}{2} = "/";
  p{8}{2} = '\';
end

end
