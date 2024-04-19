classdef TestFilePure < matlab.unittest.TestCase

properties (ClassSetupParameter)
  classToTest = {"TestFilePure"};
end

properties (TestParameter)
base_relative_to
other_relative_to
ref_relative_to
ref_proximate_to
in_is_absolute
ref_is_absolute
in_filename = {'', '/foo/bar/baz', '/foo/bar/baz/', 'foo/bar/baz.txt', 'foo/bar/baz.txt.gz'}
ref_filename = {'', 'baz', '', 'baz.txt', 'baz.txt.gz'}
dir_is_subdir
sub_is_subdir
ref_is_subdir
in_parent = {"", ".", "..", "../..", "a/b", "a/b/", "ab/.parent", "ab/.parent.txt", "a/b/../.parent.txt"}
ref_parent = {".", ".", ".", "..",   "a",   "a",    "ab",         "ab",             "a/b/.."}
in_suffix = {"", "/foo/bar/baz", "/foo/bar/baz/", "foo/bar/baz.txt", "foo/bar/baz.txt.gz", ".stat", ".stat.txt"}
ref_suffix = {"", "", "", ".txt", ".gz", ".stat", ".txt"}
end

properties
tobj
end

methods (TestParameterDefinition, Static)
function [base_relative_to, other_relative_to, ref_relative_to, ref_proximate_to] = init_relative_to(classToTest) %#ok<INUSD>

if ispc

base_relative_to = {'', 'Hello', 'Hello', ...
'c:\a\b', 'c:\', 'c:/a/b', 'c:/a/b', 'c:\a/b\c/d', 'c:/path'};

other_relative_to = {'', 'Hello', 'Hello/', ...
'c:/', 'c:/a/b', 'c:/a/b', 'c:/a', 'c:/a\b', 'd:/path'};

ref_relative_to = {'.', '.', '.', '../..', 'a/b', '.', '..', '../..', ''};

ref_proximate_to = ref_relative_to;
ref_proximate_to{end} = other_relative_to{end};

else

base_relative_to = {'', '',  '/', '/', 'Hello', 'Hello',  '/dev/null', '/a/b', 'c', ...
'/a/b', '/a/b', '/a/b/c/d', '/this/one', '/path/same'};

other_relative_to = {'', '/', '',  '/', 'Hello', 'Hello/', '/dev/null', 'c',    '/a/b', ...
'/a/b', '/a',   '/a/b',     '/this/two', '/path/same/hi/..'};

ref_relative_to = {'.', '',  '',  '.', '.',     '.',      '.',         '',     '', ...
'.',    '..',   '../..',     '../two',   '.'};

ref_proximate_to = ref_relative_to;
ref_proximate_to{2} = '/';
ref_proximate_to{8} = 'c';
ref_proximate_to{9} = '/a/b';

end

base_relative_to{end+1} =  './this/one';
other_relative_to{end+1} = './this/two';
ref_relative_to{end+1} = '../two';
ref_proximate_to{end+1} = ref_relative_to{end};

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


function test_absolute_path(tc)
import matlab.unittest.constraints.StartsWithSubstring

tc.verifyEqual(stdlib.absolute_path(""), "")

pabs = stdlib.absolute_path('2foo');
pabs2 = stdlib.absolute_path('4foo');
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = stdlib.absolute_path("../2foo");
tc.verifyNotEmpty(par1)

par2 = stdlib.absolute_path("../4foo");
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = stdlib.absolute_path("bar/../2foo");
tc.verifyNotEmpty(pt1)

va = stdlib.absolute_path("2foo");
vb = stdlib.absolute_path("4foo");
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(va, vb, 2))

end

function test_normalize(tc)

tc.verifyEqual(stdlib.normalize(""), "")

pabs = stdlib.normalize('2foo//');
tc.verifyEqual(pabs, "2foo")
end


function test_with_suffix(tc)

tc.verifyEqual(stdlib.with_suffix("", ""), "")

tc.verifyEqual(stdlib.with_suffix("foo.h5", ".nc"), "foo.nc")

tc.verifyEqual(stdlib.with_suffix("c", ""), "c")
tc.verifyEqual(stdlib.with_suffix("c.nc", ""), "c")
tc.verifyEqual(stdlib.with_suffix("", ".nc"), ".nc")
end


function test_relative_to(tc, base_relative_to, other_relative_to, ref_relative_to)
tc.verifyEqual(stdlib.relative_to(base_relative_to, other_relative_to), string(ref_relative_to))
end


function test_proximate_to(tc, base_relative_to, other_relative_to, ref_proximate_to)
tc.verifyEqual(stdlib.proximate_to(base_relative_to, other_relative_to), string(ref_proximate_to))
end


function test_is_subdir(tc, dir_is_subdir, sub_is_subdir, ref_is_subdir)
tc.verifyEqual(stdlib.is_subdir(sub_is_subdir, dir_is_subdir), ref_is_subdir)
end


end
end
