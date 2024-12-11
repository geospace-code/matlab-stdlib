classdef TestRelative < matlab.unittest.TestCase

properties (TestParameter)
p_relative_to
p_proximate_to
p_is_subdir
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


function [p_is_subdir] = init_is_subdir()

p_is_subdir = {
    {"a/b", "a/b", false}, ...
    {"a//b/c", "a/b", true}, ...
    {"a/b", "a//b", false}, ...
    {"a/./b/c", "a/b", false}, ...
    {"a/b/c", "a/./b", false}, ...
    {"a/b", "a/b/", false}, ...
    {"a/b", "a", true}, ...
    {"a/.c", "a", true}
};
% NOTE: ".." in is_subdir (either argument) is ambiguous

if ispc
  p_is_subdir{end+1} = {"c:\", "c:/", false};
else
  p_is_subdir{end+1} = {"/", "/", false};
end

end

end


methods (TestClassSetup)

function setup_path(tc)
top = fullfile(fileparts(mfilename("fullpath")), "..");
tc.applyFixture(matlab.unittest.fixtures.PathFixture(top))
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


function test_is_subdir(tc, p_is_subdir)
tc.assumeTrue(stdlib.has_java)
tc.verifyEqual(stdlib.is_subdir(p_is_subdir{1}, p_is_subdir{2}), p_is_subdir{3}, "subdir(" + p_is_subdir{1} + "," + p_is_subdir{2} + ")")
end

end

end
