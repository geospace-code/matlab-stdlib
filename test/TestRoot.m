classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture("..")}, ...
          TestTags = {'R2021a', 'pure'}) ...
    TestRoot < matlab.unittest.TestCase

properties (TestParameter)
p
rn
rd
end


methods (TestParameterDefinition, Static)
function [p, rn, rd] = init_root()

p = {{"", ""}, ...
{"a/b", ""}, ...
{"./a/b", ""}, ...
{"/etc", "/"}, ...
{'/etc', "/"}, ...
{"c:", ""}, ...
{"c:/etc", ""}, ...
{'c:\etc', ""}};

if ispc()
p{6}{2} = "c:";
p{7}{2} = "c:/";
p{8}{2} = "c:\";
end

rn = p;

rn{4}{2} = "";
rn{5}{2} = "";

if ispc()
rn{6}{2} = "c:";
rn{7}{2} = "c:";
rn{8}{2} = "c:";
end

rd = p;

if ispc()
rd{6}{2} = "";
rd{7}{2} = "/";
rd{8}{2} = "\";
end

end

end


methods (Test)

function test_root(tc, p)
r = stdlib.root(p{1});
tc.assertClass(r, 'string')
tc.verifyEqual(r, p{2})
end

function test_root_dir(tc, rd)
r = stdlib.root_dir(rd{1});
tc.assertClass(r, 'string')
tc.verifyEqual(r, rd{2}, "root_dir(" + rd{1} + ")")
end

function test_root_name(tc, rn)
r = stdlib.root_name(rn{1});
tc.assertClass(r, 'string')
tc.verifyEqual(r, rn{2})
end

end

end
