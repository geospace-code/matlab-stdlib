classdef TestRelative < matlab.unittest.TestCase

properties (TestParameter)
pr = init_rel()
pp = init_prox()
end

methods(TestClassSetup)
function mex_required(tc)
tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/relative_to." + mexext))
tc.assumeTrue(isfile(fileparts(mfilename("fullpath")) + "/../+stdlib/proximate_to." + mexext))
end
end


methods (Test)

function test_relative_to(tc, pr)
tc.verifyEqual(stdlib.relative_to(pr{1}, pr{2}), pr{3}, ...
  "relative_to(" + pr{1} + "," + pr{2}+")")
end

function test_proximate_to(tc, pp)
tc.verifyEqual(stdlib.proximate_to(pp{1}, pp{2}), pp{3}, ...
  "proximate_to(" + pp{1} + "," + pp{2}+")")
end

end
end


function p = init_rel()

p = {{"", "", "."}, ...
{"Hello", "Hello", "."}, ...
{"Hello", "Hello/", "."}, ...
{"a/./b", "a/b", "."}, ...
{"a/b", "a/./b", "."}, ...
{"./a/b", "./a/c", "../c"}, ...
{"/", "/", "."}, ...
{"a/b/c/d", "a/b", "../.."}, ...
{"a/b", "a/c", "../c"}, ...
{"a/b", "c", "../../c"}, ...
{"c", "a/b", "../a/b"}, ...
{"a/b", "a/b", "."}, ...
{"a/b", "a", ".."}
};
% NOTE: ".." in relative_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc.

if ispc
p = [p, ...
{{"C:/a/b", "C:/", "../.."}, ...
{"C:/", "C:/a/b", "a/b"}, ...
{"c:/a/b", "c:/a/b", "."}, ...
{"c:/a/b", "c:/a", ".."}, ...
{"c:\a/b\c/d", "c:/a\b", "../.."}, ...
{"C:/path", "D:/path", ""}}];
% note: on Windows the drive letter should be uppercase!
else
  p = [p, ...
{{"", "a", "a"}, ...
{"/dev/null", "/dev/null", "."}}];
end

end

function p = init_prox()
% NOTE: ".." in proximate_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc

p = init_rel();


if ispc
p{end}{3} = "D:/path";
end

end
