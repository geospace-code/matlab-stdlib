classdef (TestTags = {'R2019b', 'impure'}) ...
  TestCanonical < matlab.unittest.TestCase

properties(TestParameter)
p = {{'', ""}, ...
{"", ""}, ...
{"not-exist", "not-exist"}, ...
{"a/../b", "b"}, ...
{strcat(mfilename("fullpath"), '.m/..'), string(fileparts(mfilename("fullpath")))}, ...
{"not-exist/a/..", "not-exist"}, ...
{"./not-exist", "not-exist"}
};
backend = {"native", "legacy"}
end

methods(TestClassSetup)
function test_dirs(tc)
  pkg_path(tc)

  tc.applyFixture(matlab.unittest.fixtures.WorkingFolderFixture())
end
end


methods(Test)

function test_canonical(tc, p, backend)
try
  c = stdlib.canonical(p{1}, false, backend);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError',  e.stack(1).file + ":" + string(e.stack(1).line) + " " + e.message)
  return
end
tc.verifyEqual(c, p{2})
end

function test_canonical_array(tc, backend)
in = ["", "hi", "/ok", "not-exist/a/.."];

try
  c = stdlib.canonical(in, false, backend);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError',  e.stack(1).file + ":" + string(e.stack(1).line) + " " + e.message)
  return
end

tc.verifyEqual(c, ["", "hi", filesep + "ok", "not-exist"])
end

end

end
