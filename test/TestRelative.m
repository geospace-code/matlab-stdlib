classdef TestRelative < matlab.unittest.TestCase

properties (TestParameter)
pr = init_rel()
pp = init_prox()
end

methods (Test)

function test_relative_to(tc, pr)
tc.assumeTrue(stdlib.has_python() || (stdlib.dotnet_api() >= 5) || stdlib.is_mex_fun("stdlib.relative_to"))

tc.verifyEqual(stdlib.relative_to(pr{1}, pr{2}), pr{3}, ...
  "relative_to(" + pr{1} + "," + pr{2}+")")
end

function test_proximate_to(tc, pp)
tc.assumeTrue(stdlib.has_python() || (stdlib.dotnet_api() >= 5) || stdlib.is_mex_fun("stdlib.proximate_to"))

tc.verifyEqual(stdlib.proximate_to(pp{1}, pp{2}), pp{3}, ...
  "proximate_to(" + pp{1} + ", " + pp{2}+")")
end

end
end


function p = init_rel()

p = {{"", "", "."}, ...
{"Hello", "Hello", "."}, ...
{"Hello", "Hello/", "."}, ...
{"a/./b", "a/b", "."}, ...
{"a/b", "a/./b", "."}, ...
{"/", "/", "."}, ...
{"a/b", "a/b", "."} ...
};
% NOTE: ".." in relative_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc.

if stdlib.has_dotnet() || stdlib.version_atleast(stdlib.python_version(), "3.12")
p = [p, {
{"a/b/c/d", "a/b", fullfile("..", "..")}, ...
{"a/b", "a/c", fullfile("..", "c")}, ...
{"a/b", "c", fullfile("..", "..", "c")}, ...
{"c", "a/b", fullfile("..", "a", "b")}, ...
{"a/b", "a", ".."}, ...
  }];
end

if ispc

if stdlib.has_dotnet() || stdlib.version_atleast(stdlib.python_version(), "3.12")
p = [p, { ...
{"C:/a/b", "C:/", fullfile("..", "..")}, ...
{"c:/a/b", "c:/a", ".."}, ...
{"c:\a/b\c/d", "c:/a\b", fullfile("..", "..")}
  }];
end

p = [p, {
{"C:/", "C:/a/b", fullfile("a", "b")}, ...
{"c:/a/b", "c:/a/b", "."}, ...
{"C:/path", "D:/path", ""}, ...
{"D:/a/b", "c", ""}}];
% note: on Windows the drive letter should be uppercase!

else

p = [p, ...
{{"", "a", "a"}, ...
{"/dev/null", "/dev/null", "."}, ...
{"/a/b", "c", ""}}];
end

end

function p = init_prox()
% NOTE: ".." in proximate_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc

p = init_rel();

if ispc
p{end-1}{3} = fullfile("D:", "path");
end

p{end}{3} = "c";

end
