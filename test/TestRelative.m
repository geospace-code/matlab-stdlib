classdef TestRelative < matlab.unittest.TestCase

properties (TestParameter)
p_relative_to
p_proximate_to
end


methods (TestParameterDefinition, Static)

function [p_relative_to, p_proximate_to] = init_relative_to()

p_relative_to = {{"", "", "."}, ...
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

p_proximate_to = p_relative_to;

p_proximate_to{8}{3} = "/";
p_proximate_to{12}{3} = "c";
p_proximate_to{13}{3} = "/a/b";

if ispc

p_relative_to = [p_relative_to, ...
{{"c:\a\b", "c:/", "../.."}, ...
{"c:\", "c:/a/b", "a/b"}, ...
{"c:/a/b", "c:/a/b", "."}, ...
{"c:/a/b", "c:/a", ".."}, ...
{"c:\a/b\c/d", "c:/a\b", "../.."}, ...
{"c:/path", "d:/path", ""}}];

p_proximate_to = p_relative_to;
% NOTE: ".." in proximate_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc

p_proximate_to{8}{3} = "/";
p_proximate_to{12}{3} = "c";
p_proximate_to{13}{3} = "/a/b";

p_proximate_to{end}{3} = "d:/path";
end

end

end



methods (Test)

function test_relative_to(tc, p_relative_to)
tc.assumeTrue(stdlib.has_java)
tc.verifyEqual(stdlib.relative_to(p_relative_to{1}, p_relative_to{2}), p_relative_to{3}, "relative_to(" + p_relative_to{1} + "," + p_relative_to{2}+")")
end


function test_proximate_to(tc, p_proximate_to)
tc.assumeTrue(stdlib.has_java)
tc.verifyEqual(stdlib.proximate_to(p_proximate_to{1}, p_proximate_to{2}), p_proximate_to{3}, "proximate_to(" + p_proximate_to{1} + "," + p_proximate_to{2}+")")
end

end

end
