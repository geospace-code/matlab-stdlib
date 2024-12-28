classdef TestFilePure < matlab.unittest.TestCase

properties (TestParameter)

p_is_absolute

p_filename = {
  {"", ""}, ...
  {"/a/b/c", "c"}, ...
  {"/a/b/c/", ""}, ...
  {"a/b/c.txt", "c.txt"}, ...
  {"a/b/c.txt.gz", "c.txt.gz"}
};

p_stem ={{"/a/b/c", "c"}, {"/a/b/c/", ""}, {"a/b/c/", ""}, ...
{"a/b/c.txt", "c"}, {"a/b/c.txt.gz", "c.txt"}, ...
{"a/b/.c", ".c"}}

p_suffix = {{"", ""}, {"/a/b/c", ""}, {"/a/b/c/", ""}, {"a/b/c.txt", ".txt"}, {"a/b/c.txt.gz", ".gz"}, {".stat", ".stat"}, {".stat.txt", ".txt"}}

p_root
p_root_name
end


methods (TestParameterDefinition, Static)

function [p_root, p_root_name] = init_relative_to()

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

if ispc
p_root{5}{2} = "c:";
p_root{6}{2} = "c:/";

p_root_name{4}{2} = "c:";
end

end


function [p_is_absolute] = init_is_absolute()
p_is_absolute = {{"", false}, {"x", false}, {"x:", false}, {"x:/foo", false}, {"/foo", true}};
if ispc
  p_is_absolute{4}{2} = true;
  p_is_absolute{5}{2} = false;
end
end

end


methods (Test)

function test_posix(tc)
import matlab.unittest.constraints.ContainsSubstring

tc.verifyEqual(stdlib.posix(""), "")

if ispc
  tc.verifyThat(stdlib.posix("c:\foo"), ~ContainsSubstring("\"))
end
end

function test_filename(tc, p_filename)
tc.verifyEqual(stdlib.filename(p_filename{1}), p_filename{2})
end

function test_suffix(tc, p_suffix)
tc.verifyEqual(stdlib.suffix(p_suffix{1}), p_suffix{2})
end


function test_stem(tc, p_stem)
tc.verifyEqual(stdlib.stem(p_stem{1}), p_stem{2})
end

function test_is_absolute(tc, p_is_absolute)
ok = stdlib.is_absolute(p_is_absolute{1}, stdlib.has_java());
tc.verifyEqual(ok, p_is_absolute{2}, p_is_absolute{1})
end

function test_root(tc, p_root)
tc.verifyEqual(stdlib.root(p_root{1}), p_root{2})
end

end
end
