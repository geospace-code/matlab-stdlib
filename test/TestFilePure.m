classdef TestFilePure < matlab.unittest.TestCase

properties (ClassSetupParameter)
  classToTest = {"TestFilePure"};
end

properties (TestParameter)
p_relative_to
p_proximate_to
in_is_absolute
ref_is_absolute
in_filename = {'', '/foo/bar/baz', '/foo/bar/baz/', 'foo/bar/baz.txt', 'foo/bar/baz.txt.gz'}
ref_filename = {'', 'baz', '', 'baz.txt', 'baz.txt.gz'}
dir_is_subdir
sub_is_subdir
ref_is_subdir

in_parent
ref_parent

p_join = {{"", "", ""}, ...
{"a", "", "a"}, ...
{"", "a", "a"}, ...
{"a/b/", "c/", "a/b/c"}, ...
{"/", "", "/"}, ...
{"", "/", "/"}, ...
{"a", "b//", "a/b"}, ...
{"a//", "b//", "a/b"}, ...
{"a/b/../", "c/d/../", "a/c"}, ...
{"a/b", "..", "a"}, ...
{"a/b", "c/d", "a/b/c/d"}, ...
{"ab/cd", "/ef", "/ef"} ...
};

in_suffix = {"", "/foo/bar/baz", "/foo/bar/baz/", "foo/bar/baz.txt", "foo/bar/baz.txt.gz", ".stat", ".stat.txt"}
ref_suffix = {"", "", "", ".txt", ".gz", ".stat", ".txt"}

in_norm = {"", "a/..", "//a/b/", "/a/b/", "a/b/", "a/../c", "a/b/../c", "a/b/../../c", "a/b/../../c/..", ...
    "a/b/../../c/../..", "a////b", ".a", "..a", "a.", "a..", "./a/.", "../a"}
ref_norm = {".", ".", "/a/b", "/a/b", "a/b", "c", "a/c", "c", ".", ...
    "..", "a/b", ".a", "..a", "a.", "a..", "a", "../a"}

in_root
ref_root
end

properties
tobj
end

methods (TestParameterDefinition, Static)
function [p_relative_to, p_proximate_to, in_root, ref_root, in_parent, ref_parent] = init_relative_to(classToTest) %#ok<INUSD>

in_root = {"", "a/b", "./a/b", "../a/b", "/etc", "c:/etc"};
ref_root = {"", "", "", "", "/", ""};

in_parent = {"", ".", "..", "../..", "a/", "a/b", "a/b/", "ab/.parent", "ab/.parent.txt", "a/b/../.parent.txt", "a/////b////c", "c:/", "c:\", "c:/a/b", "c:\a/b"};
ref_parent = {".", ".", ".", "..",   ".",  "a",   "a",    "ab",         "ab",             "a/b/..",             "a/b",          ".",    ".",    "c:/a",     "c:\a"};

p_relative_to = {{'', '', '.'}, ...
{'Hello', 'Hello', '.'}, ...
{'Hello', 'Hello/', '.'}, ...
{'./this/one', './this/two', '../two'}, ...
{'/path/same', '/path/same/hi/..', '.'}, ...
{'', '/', ''}, ...
{'/', '', ''}, ...
{'/', '/', '.'}, ...
{'/dev/null', '/dev/null', '.'}, ...
{'/a/b', 'c', ''}, ...
{'c', '/a/b', ''}, ...
{'/a/b', '/a/b', '.'}, ...
{'/a/b', '/a', '..'}, ...
{'/a/b/c/d', '/a/b', '../..'}, ...
{'/this/one', '/this/two', '../two'}, ...
{'/path/same', '/path/same/hi/..', '.'}};

p_proximate_to = p_relative_to;

p_proximate_to{6}{3} = '/';
p_proximate_to{10}{3} = 'c';
p_proximate_to{11}{3} = '/a/b';

if ispc

p_relative_to = [p_relative_to, ...
{{'c:\a\b', 'c:/', '../..'}, ...
{'c:\', 'c:/a/b', 'a/b'}, ...
{'c:/a/b', 'c:/a/b', '.'}, ...
{'c:/a/b', 'c:/a', '..'}, ...
{'c:\a/b\c/d', 'c:/a\b', '../..'}, ...
{'c:/path', 'd:/path', ''}}];

p_proximate_to = p_relative_to;

p_proximate_to{6}{3} = '/';
p_proximate_to{10}{3} = 'c';
p_proximate_to{11}{3} = '/a/b';

p_proximate_to{end}{3} = "d:/path";

ref_parent{12} = "c:/";
ref_parent{13} = "c:/";
ref_parent{14} = "c:/a";
ref_parent{15} = "c:/a";

ref_root{5} = "";
ref_root{6} = "c:/";

end  % if ispc

end


function [in_is_absolute, ref_is_absolute] = init_is_absolute(classToTest) %#ok<INUSD>

in_is_absolute = {'', 'x', 'x:/foo', '/foo'};
ref_is_absolute = {false, false};

if ispc
  ref_is_absolute{end+1} = true;
  ref_is_absolute{end+1} = false;
else
  ref_is_absolute{end+1} = false;
  ref_is_absolute{end+1} = true;
end

end


function [dir_is_subdir, sub_is_subdir, ref_is_subdir] = init_is_subdir(classToTest) %#ok<INUSD>

dir_is_subdir = {"a/b", "a/b", "a/b", "a"};
sub_is_subdir = {"a/b", "a/b/", "a", "a/.c"};
ref_is_subdir = {false, false, false, true};

if ispc

dir_is_subdir{end+1} = "c:\";
sub_is_subdir{end+1} = "c:/";
ref_is_subdir{end+1} = false;

else

dir_is_subdir{end+1} = "/";
sub_is_subdir{end+1} = "/";
ref_is_subdir{end+1} = false;

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



methods (Test, ParameterCombination = 'sequential')

function test_posix(tc)
import matlab.unittest.constraints.ContainsSubstring

tc.verifyEmpty(stdlib.posix(string.empty))
tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyThat(stdlib.posix("c:\foo"), ~ContainsSubstring("\"))
  tc.verifyThat(stdlib.posix(["x:\123", "d:\abc"]), ~ContainsSubstring("\"))
end
end


function test_join(tc, p_join)
tc.verifyEqual(stdlib.join(p_join{1}, p_join{2}), p_join{3})
end


function test_filename(tc, in_filename, ref_filename)
tc.verifyEqual(stdlib.filename(in_filename), string(ref_filename))
end


function test_parent(tc, in_parent, ref_parent)
tc.verifyEqual(stdlib.parent(in_parent), ref_parent)
end

function test_suffix(tc, in_suffix, ref_suffix)
tc.verifyEqual(stdlib.suffix(in_suffix), string(ref_suffix))
end


function test_stem(tc)

tc.verifyEmpty(stdlib.stem(string.empty))
tc.verifyEqual(stdlib.stem(""), "")

tc.verifyEqual(stdlib.stem("/foo/bar/baz"), "baz")
tc.verifyEqual(stdlib.stem("/foo/bar/baz/"), "")

tc.verifyEqual(stdlib.stem("foo/bar/baz/"), "")

tc.verifyEqual(stdlib.stem("foo/bar/baz.txt"), "baz")
tc.verifyEqual(stdlib.stem("foo/bar/baz.txt.gz"), "baz.txt")

end


function test_is_absolute(tc, in_is_absolute, ref_is_absolute)
tc.verifyEqual(stdlib.is_absolute(in_is_absolute), ref_is_absolute)
end


function test_normalize(tc, in_norm, ref_norm)

tc.verifyEqual(stdlib.normalize(in_norm), ref_norm)

end


function test_root(tc, in_root, ref_root)

tc.verifyEqual(stdlib.root(in_root), ref_root)

end


function test_with_suffix(tc)

tc.verifyEqual(stdlib.with_suffix("", ""), "")

tc.verifyEqual(stdlib.with_suffix("foo.h5", ".nc"), "foo.nc")

tc.verifyEqual(stdlib.with_suffix("c", ""), "c")
tc.verifyEqual(stdlib.with_suffix("c.nc", ""), "c")
tc.verifyEqual(stdlib.with_suffix("", ".nc"), ".nc")
end


function test_relative_to(tc, p_relative_to)
tc.assumeTrue(stdlib.has_java)
tc.verifyEqual(stdlib.relative_to(p_relative_to{1}, p_relative_to{2}), string(p_relative_to{3}))
end


function test_proximate_to(tc, p_proximate_to)
tc.assumeTrue(stdlib.has_java)
tc.verifyEqual(stdlib.proximate_to(p_proximate_to{1}, p_proximate_to{2}), string(p_proximate_to{3}))
end


function test_is_subdir(tc, dir_is_subdir, sub_is_subdir, ref_is_subdir)
tc.assumeTrue(stdlib.has_java)
tc.verifyEqual(stdlib.is_subdir(sub_is_subdir, dir_is_subdir), ref_is_subdir)
end


end
end
