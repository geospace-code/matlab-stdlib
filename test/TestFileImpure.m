classdef TestFileImpure < matlab.unittest.TestCase

properties (ClassSetupParameter)
  classToTest = {"TestFileImpure"};
end

properties(TestParameter)
in_exists = {pwd, mfilename("fullpath") + ".m", "not-exists"}
ref_exists = {true, true, false}
% on CI matlabroot can be writable!
in_is_write = {pwd, "not-exists"};
ref_is_write = {true, false}
in_expand = {"", "~abc", "~", "~/foo"}
ref_expand
in_same = {"", tempname, "..", ".."}
other_same = {"", tempname, "./..", fullfile(pwd, "..")}
ref_same = {false, false, true, true}
end

properties
tobj
end


methods (TestParameterDefinition, Static)

function ref_expand = init_expand(classToTest) %#ok<INUSD>
cwd = fileparts(mfilename("fullpath"));
top = fullfile(cwd, "..");
addpath(top)

ref_expand = {"", "~abc", stdlib.homedir, stdlib.join(stdlib.homedir, "foo")};
end
end


methods(TestClassSetup)

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

function test_exists(tc, in_exists, ref_exists)
tc.verifyEqual(stdlib.exists(in_exists), ref_exists)
end


function test_is_readable(tc, in_exists, ref_exists)
tc.verifyEqual(stdlib.is_readable(in_exists), ref_exists)
end


function test_is_writable(tc, in_is_write, ref_is_write)
tc.verifyEqual(stdlib.is_writable(in_is_write), ref_is_write)
end


function test_expanduser(tc, in_expand, ref_expand)
tc.verifyEqual(stdlib.expanduser(in_expand), ref_expand)
end


function test_null_file(tc)
import matlab.unittest.constraints.IsFile
tc.assumeFalse(ispc)
tc.verifyThat(stdlib.null_file, IsFile)
end


function test_is_regular_file(tc)
  import matlab.unittest.constraints.IsFile
if ~ispc
  tc.assumeThat(stdlib.null_file, IsFile)
end
tc.verifyFalse(stdlib.is_regular_file(stdlib.null_file), "null file is not a regular file")

end


function test_touch_modtime(tc)

fn = tempname;
tc.verifyTrue(stdlib.touch(fn))
t0 = stdlib.get_modtime(fn);

pause(1.)  % empirical to avoid failing >=.  0.4 failed intermittantly
tc.verifyTrue(stdlib.set_modtime(fn))
t1 = stdlib.get_modtime(fn);

tc.verifyGreaterThanOrEqual(t1, t0)

end


function test_absolute(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.EndsWithSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

tc.verifyEqual(stdlib.absolute(""), stdlib.posix(td))
tc.verifyEqual(stdlib.absolute("",""), stdlib.posix(td))
tc.verifyEqual(stdlib.absolute("hi"), stdlib.join(td, "hi"))
tc.verifyEqual(stdlib.absolute("", "hi"), stdlib.join(td, "hi"))
tc.verifyEqual(stdlib.absolute("there", "hi"), stdlib.join(td, "hi/there"))

end



function test_canonical(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.EndsWithSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

% all non-existing files

tc.verifyEqual(stdlib.canonical(""), ".")

pabs = stdlib.canonical('2foo');
tc.verifyThat(pabs, StartsWithSubstring("2foo"))

par1 = stdlib.canonical("../2foo");
tc.verifyThat(par1, StartsWithSubstring(".."))

pt1 = stdlib.canonical("bar/../2foo");
tc.verifyEqual(pt1, "2foo")

% test existing file
r = stdlib.parent(mfilename('fullpath'));
tc.verifyEqual(stdlib.canonical(fullfile(r, "..")), stdlib.parent(r))

% on windows, ~ is expanded even without expanduser
if ~ispc
tc.verifyThat(stdlib.canonical("~", false), EndsWithSubstring("~"))
end

h = stdlib.homedir;
tc.verifyEqual(stdlib.canonical("~"), h)
tc.verifyEqual(stdlib.canonical("~/"), h)
tc.verifyEqual(stdlib.canonical("~/.."), stdlib.parent(h))

tc.verifyEqual(stdlib.canonical("nobody.txt"), "nobody.txt")
tc.verifyEqual(stdlib.canonical("../nobody.txt"), "../nobody.txt")

end


function test_resolve(tc)
import matlab.unittest.fixtures.TemporaryFolderFixture
import matlab.unittest.fixtures.CurrentFolderFixture
import matlab.unittest.constraints.StartsWithSubstring
import matlab.unittest.constraints.EndsWithSubstring
import matlab.unittest.constraints.ContainsSubstring

td = tc.applyFixture(TemporaryFolderFixture).Folder;
tc.applyFixture(CurrentFolderFixture(td))

% all non-existing files

tc.verifyEqual(stdlib.resolve(""), stdlib.posix(td))

pabs = stdlib.resolve('2foo');
pabs2 = stdlib.resolve('4foo');
tc.verifyThat(pabs, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(pabs, pabs2, 2))

par1 = stdlib.resolve("../2foo");
tc.verifyNotEmpty(par1)
tc.verifyThat(par1, ~ContainsSubstring(".."))

par2 = stdlib.resolve("../4foo");
tc.verifyTrue(strncmp(par2, pabs2, 2))

pt1 = stdlib.resolve("bar/../2foo");
tc.verifyNotEmpty(pt1)
tc.verifyThat(pt1, ~ContainsSubstring(".."))

va = stdlib.resolve("2foo");
vb = stdlib.resolve("4foo");
tc.verifyThat(va, ~StartsWithSubstring("2"))
tc.verifyTrue(strncmp(va, vb, 2))

% test existing file
r = stdlib.parent(mfilename('fullpath'));
rp = stdlib.parent(r);
tc.verifyEqual(stdlib.resolve(rp), stdlib.parent(r))

h = stdlib.homedir;
tc.verifyEqual(stdlib.resolve("~"), h)
tc.verifyEqual(stdlib.resolve("~/"), h)
tc.verifyEqual(stdlib.resolve("~/.."), stdlib.parent(h))

tc.verifyEqual(stdlib.resolve("nobody.txt"), stdlib.join(td, "nobody.txt"))
tc.verifyEqual(stdlib.resolve("../nobody.txt"), stdlib.join(stdlib.parent(td), "nobody.txt"))

end


function test_makedir(tc)
import matlab.unittest.constraints.IsFolder
d = tempname;
stdlib.makedir(d)
tc.assertThat(d, IsFolder)
end

%%
function test_samepath(tc, in_same, other_same, ref_same)
tc.verifyEqual(stdlib.samepath(in_same, other_same), ref_same)
end

%%
function test_which_name(tc)

tc.verifyEmpty(stdlib.which(tempname))

if ispc
  n = "pwsh.exe";
else
  n = "ls";
end
%% which: Matlab in environment variable PATH
% MacOS Matlab does not source .zshrc so Matlab is not on internal Matlab PATH
% Unix-like OS may have Matlab as alias which is not visible to
% stdlib.which()
% virus scanners may block stdlib.which("cmd.exe") on Windows
tc.verifyNotEmpty(stdlib.which(n))

end


function test_is_exe_which_fullpath(tc)
import matlab.unittest.constraints.IsFile
import matlab.unittest.constraints.EndsWithSubstring

tc.verifyFalse(stdlib.is_exe(""))
tc.verifyFalse(stdlib.is_exe(tempname))

n = "matlab";
%% is_exe test
p = fullfile(matlabroot, "bin", n);
if ispc
  fp = p + ".exe";
else
  fp = p;
end
tc.verifyTrue(stdlib.is_exe(fp))
%% which: test absolute path
exe = stdlib.which(p);

if ispc
  tc.verifyThat(exe, EndsWithSubstring(".exe"))
else
  tc.verifyThat(exe, ~EndsWithSubstring(".exe"))
end
tc.verifyThat(exe, IsFile)

end

function test_hash(tc)
import matlab.unittest.constraints.IsFile
import matlab.unittest.fixtures.TemporaryFolderFixture

fixture = tc.applyFixture(TemporaryFolderFixture);

fn = stdlib.join(fixture.Folder, "hello");
fid = fopen(fn, "w");
tc.assumeGreaterThan(fid, 0);
fprintf(fid, "hello");
fclose(fid);
tc.assumeThat(fn, IsFile)

tc.verifyEqual(stdlib.file_checksum(fn, "md5"), "5d41402abc4b2a76b9719d911017c592")
tc.verifyEqual(stdlib.file_checksum(fn, "sha256"), "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824")

end


function test_filesystem_type(tc)

import matlab.unittest.constraints.IsOfClass

t = stdlib.filesystem_type(".");

tc.verifyThat(t, IsOfClass('string'))

end


function test_owner(tc)

owner = stdlib.get_owner('.');
L = strlength(owner);
tc.verifyGreaterThan(L, 0, "expected non-empty username")

end


function test_username(tc)

u = stdlib.get_username();
L = strlength(u);
tc.verifyGreaterThan(L, 0, "expected non-empty username")

end

function test_hostname(tc)
h = stdlib.hostname();
L = strlength(h);
tc.verifyGreaterThan(L, 0, "expected non-empty hostname")

end

function test_getpid(tc)
pid = stdlib.getpid();
tc.verifyGreaterThan(pid, 0, "expected positive PID")
end

function test_get_permissions(tc)
import matlab.unittest.constraints.StartsWithSubstring
p = stdlib.get_permissions(".");
tc.verifyThat(p, StartsWithSubstring("r"))
end

function test_handle2filename(tc)
tc.verifyEqual(stdlib.handle2filename(0), '"' + "stdin" + '"')
tc.verifyEqual(stdlib.handle2filename(1), '"' + "stdout" + '"')
tc.verifyEqual(stdlib.handle2filename(2), '"' + "stderr" + '"')
tc.verifyEmpty(stdlib.handle2filename(fopen(tempname)))
end

function test_java_version(tc)
v = stdlib.java_version();
L = strlength(v);
tc.verifyGreaterThanOrEqual(L, 4)
end

function test_java_api(tc)
v = stdlib.java_api();
tc.verifyGreaterThanOrEqual(v, 8)
end

function test_hard_link_count(tc)

fn = mfilename("fullpath") + ".m";

if ispc
  tc.verifyEmpty(stdlib.hard_link_count(fn))
else
  tc.verifyGreaterThanOrEqual(stdlib.hard_link_count(fn), 1)
end

tc.verifyEmpty(stdlib.hard_link_count(tempname))

end

end

end
