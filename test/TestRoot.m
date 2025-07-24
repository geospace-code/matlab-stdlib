classdef TestRoot < matlab.unittest.TestCase

properties (TestParameter)
p = init_root()
rn = init_root_name()
rd = init_root_dir()
end

methods (Test, TestTags="pure")

function test_root(tc, p)
tc.verifyEqual(stdlib.root(p{1}), p{2})
end

function test_root_dir(tc, rd)
tc.verifyEqual(stdlib.root_dir(rd{1}), rd{2}, "root_dir(" + rd{1} + ")")
end

function test_root_name(tc, rn)
tc.verifyEqual(stdlib.root_name(rn{1}), rn{2})
end

end

end % class


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


function rn = init_root_name()

rn = init_root();

rn{4}{2} = "";
rn{5}{2} = '';

if ispc()
rn{6}{2} = "c:";
rn{7}{2} = "c:";
rn{8}{2} = 'c:';
end

end


function rd = init_root_dir()

rd = init_root();

if ispc()
rd{6}{2} = "";
rd{7}{2} = "/";
rd{8}{2} = '\';
end

end
