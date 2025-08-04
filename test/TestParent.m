classdef TestParent < matlab.unittest.TestCase

properties (TestParameter)
p = init_parent()
backend = {"java", "python", "native"}
end

methods(TestClassSetup)
function pkg_path(tc)
fsp = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(fsp)
end
end

methods (Test, TestTags="pure")

function test_parent(tc, p, backend)
try
  pr = stdlib.parent(p{1}, backend);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.stack(1).file + ":" + string(e.stack(1).line) + " " + e.message)
  return
end
tc.verifyEqual(pr, p{2}, sprintf("parent(%s, %s)", p{1}, backend))
end

end

end


function p = init_parent()

p = {
{"", "."}, ...
{".", "."}, ...
{"..", "."}, ...
{"../..", ".."}, ...
{"a/", "."}, ...
{"a/b", "a"}, ...
{"ab/.parent", "ab"}, ...
{"ab/.parent.txt", "ab"}, ...
{"a/b/../.parent.txt", fullfile("a", "b", "..")}};

if ispc
p{end+1} = {"c:/", "c:\"};
p{end+1} = {"c:\", "c:\"};
p{end+1} = {"c:/a/b", "c:\a"};
p{end+1} = {"c:\a/b", "c:\a"};
p{end+1} = {"c:/a", "c:\"};
p{end+1} = {"c:", "c:\"};
end

p{end+1} = {'a/b/', "a"};
p{end+1} = {'a//b', "a"};

end
