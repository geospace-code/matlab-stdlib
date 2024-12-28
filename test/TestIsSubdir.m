classdef TestIsSubdir < matlab.unittest.TestCase

properties (TestParameter)
p_is_prefix
p_is_subdir
end

methods (TestParameterDefinition, Static)

function [p_is_subdir, p_is_prefix] = init_is_subdir()

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

p_is_prefix = p_is_subdir;
p_is_prefix{1}{3} = true;
p_is_prefix{2}{3} = false;
p_is_prefix{3}{3} = true;
p_is_prefix{6}{3} = true;
p_is_prefix{7}{3} = false;
p_is_prefix{8}{3} = false;
p_is_prefix{9}{3} = true;

end

end

methods (Test)

function test_is_subdir(tc, p_is_subdir)
tc.verifyEqual(stdlib.is_subdir(p_is_subdir{1}, p_is_subdir{2}), p_is_subdir{3}, "subdir(" + p_is_subdir{1} + "," + p_is_subdir{2} + ")")
end

function test_is_prefix(tc, p_is_prefix)
tc.verifyEqual(stdlib.is_prefix(p_is_prefix{1}, p_is_prefix{2}), p_is_prefix{3}, "prefix(" + p_is_prefix{1} + "," + p_is_prefix{2} + ")")
end

end

end