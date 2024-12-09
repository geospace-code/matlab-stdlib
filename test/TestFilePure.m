classdef TestFilePure < matlab.unittest.TestCase

properties (ClassSetupParameter)
  classToTest = {"TestFilePure"};
end

properties (TestParameter)
p_relative_to
p_proximate_to
p_is_absolute
in_filename = {"", "/a/b/c", "/a/b/c/", "a/b/c.txt", "a/b/c.txt.gz"}
ref_filename = {"", "c", "", "c.txt", "c.txt.gz"}

p_is_subdir
p_parent

p_join = {{"", "", ""}, ...
{"a", "", "a"}, ...
{"", "a", "a"}, ...
{"a/b/", "c/", "a/b/c"}, ...
{"/", "", "/"}, ...
{"", "/", "/"}, ...
{"a", "b//", "a/b"}, ...
{"a//", "b//", "a/b"}, ...
{"a/b/../", "c/d/../", "a/b/../c/d/.."}, ...
{"a/b", "..", "a/b/.."}, ...
{"a/b", "c/d", "a/b/c/d"}, ...
{"ab/cd", "/ef", "/ef"} ...
};

in_suffix = {"", "/a/b/c", "/a/b/c/", "a/b/c.txt", "a/b/c.txt.gz", ".stat", ".stat.txt"}
ref_suffix = {"", "", "", ".txt", ".gz", ".stat", ".txt"}

in_norm = {"", "a/..", "//a/b/", "/a/b/", "a/b/", "a/../c", "a/b/../c", "a/b/../../c", "a/b/../../c/..", ...
    "a/b/../../c/../..", "a////b", ".a", "..a", "a.", "a..", "./a/.", "../a"}
ref_norm = {".", ".", "/a/b", "/a/b", "a/b", "c", "a/c", "c", ".", ...
    "..", "a/b", ".a", "..a", "a.", "a..", "a", "../a"}

p_root
p_root_name
end

properties
tobj
end

methods (TestParameterDefinition, Static)
function [p_relative_to, p_proximate_to, p_root, p_root_name, p_parent] = init_relative_to(classToTest) %#ok<INUSD>

p_root = {{"", ""}, ...
{"a/b", ""}, ...
{"./a/b", ""}, ...
{"/etc", "/"}, ...
{"c:", ""}, ...
{"c:/etc", ""}};

p_root_name = {{"", ""}, ...
{"a/b", ""}, ...
{"/etc", ""}, ...
{"c:/etc", ""}};

p_parent = {
  {"", "."}, ...
  {".", "."}, ...
  {"..", "."}, ...
  {"../..", ".."}, ...
  {"a/", "."}, ...
  {"a/b", "a"}, ...
  {"a/b/", "a"}, ...
  {"ab/.parent", "ab"}, ...
  {"ab/.parent.txt", "ab"}, ...
  {"a/b/../.parent.txt", "a/b/.."}, ...
  {"a/////b////c", "a/b"}, ...
  {"c:/", "."}, ...
  {"c:\", "."}, ...
  {"c:/a/b", "c:/a"}, ...
  {"c:\a/b", "c:\a"}
};

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

p_proximate_to{6}{3} = "/";
p_proximate_to{10}{3} = "c";
p_proximate_to{11}{3} = "/a/b";

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

p_parent{12}{2} = "c:/";
p_parent{13}{2} = "c:/";
p_parent{14}{2} = "c:/a";
p_parent{15}{2} = "c:/a";
p_parent{end+1} =  {"c:/a", "c:/"};
p_parent{end+1} = {"c:", "c:/"};

p_root{5}{2} = "c:";
p_root{6}{2} = "c:/";

p_root_name{4}{2} = "c:";

end  % if ispc

end


function [p_is_absolute] = init_is_absolute(classToTest) %#ok<INUSD>

p_is_absolute = {{"", false}, {"x", false}, {"x:", false}, {"x:/foo", false}, {"/foo", true}};

if ispc
  p_is_absolute{4}{2} = true;
  p_is_absolute{5}{2} = false;
end

end


function [p_is_subdir] = init_is_subdir(classToTest) %#ok<INUSD>

p_is_subdir = {
  {"a/b", "a/b", false}, ...
  {"a//b/c", "a/b", false}, ...
  {"a/b", "a//b", false}, ...
  {"a/./b/c", "a/b", false}, ...
  {"a/b/c", "a/./b", true}, ...
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

function classSetup(tc, classToTest)
constructor = str2func(classToTest);
tc.tobj = constructor();
end

function setup_path(tc)
import matlab.unittest.fixtures.PathFixture
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
tc.applyFixture(PathFixture(top))
end

end



methods (Test, ParameterCombination = "sequential")

function test_posix(tc)
import matlab.unittest.constraints.ContainsSubstring

tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyThat(stdlib.posix("c:\foo"), ~ContainsSubstring("\"))
end
end


function test_join(tc, p_join)
tc.verifyEqual(stdlib.join(p_join{1}, p_join{2}), p_join{3})
end


function test_filename(tc, in_filename, ref_filename)
tc.verifyEqual(stdlib.filename(in_filename), string(ref_filename))
end


function test_parent(tc, p_parent)
tc.verifyEqual(stdlib.parent(p_parent{1}), p_parent{2}, p_parent{1})
end

function test_suffix(tc, in_suffix, ref_suffix)
tc.verifyEqual(stdlib.suffix(in_suffix), string(ref_suffix))
end


function test_stem(tc)

tc.verifyEqual(stdlib.stem(""), "")

tc.verifyEqual(stdlib.stem("/a/b/c"), "c")
tc.verifyEqual(stdlib.stem("/a/b/c/"), "")

tc.verifyEqual(stdlib.stem("a/b/c/"), "")

tc.verifyEqual(stdlib.stem("a/b/c.txt"), "c")
tc.verifyEqual(stdlib.stem("a/b/c.txt.gz"), "c.txt")

end


function test_is_absolute(tc, p_is_absolute)
tc.verifyEqual(stdlib.is_absolute(p_is_absolute{1}), p_is_absolute{2}, p_is_absolute{1})
end


function test_normalize(tc, in_norm, ref_norm)

tc.verifyEqual(stdlib.normalize(in_norm), ref_norm)

end


function test_root(tc, p_root)
tc.verifyEqual(stdlib.root(p_root{1}), p_root{2})
end


function test_with_suffix(tc)

tc.verifyEqual(stdlib.with_suffix("", ""), "")

tc.verifyEqual(stdlib.with_suffix("foo.h5", ".nc"), "foo.nc")

tc.verifyEqual(stdlib.with_suffix("c", ""), "c")
tc.verifyEqual(stdlib.with_suffix("c.nc", ""), "c")
tc.verifyEqual(stdlib.with_suffix("", ".nc"), ".nc")

tc.verifyEqual(stdlib.with_suffix("a//b///c///", ".h5"), "a/b/c/.h5")
end


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
