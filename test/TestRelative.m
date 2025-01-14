classdef TestRelative < matlab.unittest.TestCase

properties (TestParameter)
pr = init_rel()
pp = init_prox()
end

methods(TestClassSetup)
function java_required(tc)
tc.assumeTrue(stdlib.has_java())
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
{"./this/one", "./this/two", "../two"}, ...
{"/path/same", "/path/same/hi/..", "hi/.."}, ...
{"", "/", ""}, ...
{"/", "", ""}, ...
{"/", "/", "."}, ...
{"/dev/null", "/dev/null", "."}, ...
{"/a/b", "c", ""}, ...
{"c", "/a/b", ""}, ...
{"/a/b", "/a/b", "."}, ...
{"/a/b", "/a", ".."}, ...
{"/a/b/c/d", "/a/b", "../.."}, ...
{"this/one", "this/two", "../two"}};
% NOTE: ".." in relative_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc.

if ispc
p = [p, ...
{{"c:\a\b", "c:/", "../.."}, ...
{"c:\", "c:/a/b", "a/b"}, ...
{"c:/a/b", "c:/a/b", "."}, ...
{"c:/a/b", "c:/a", ".."}, ...
{"c:\a/b\c/d", "c:/a\b", "../.."}, ...
{"c:/path", "d:/path", ""}}];
end

end

function p = init_prox()
% NOTE: ".." in proximate_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc

p = init_rel();

p{8}{3} = "/";
p{12}{3} = "c";
p{13}{3} = "/a/b";

if ispc
p{8}{3} = "/";
p{12}{3} = "c";
p{13}{3} = "/a/b";

p{end}{3} = "d:/path";
end

p{end+1} = {"file:///", "file:///", ""};

end
