classdef TestRelative < matlab.unittest.TestCase

properties
td
end

properties (TestParameter)
pr = init_rel()
pp = init_prox()
rel_fun = {"native", "python"}
end

methods(TestClassSetup)
function pkg_path(tc)
p = matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))));
tc.applyFixture(p)
end
end


methods (Test)

function test_relative_to(tc, pr, rel_fun)
try
  r = stdlib.relative_to(pr{1}, pr{2}, rel_fun);
catch e
  tc.verifyEqual(e.identifier, 'stdlib:hbackend:NameError', e.message)
  return
end
tc.verifyEqual(r, pr{3}, "relative_to(" + pr{1} + "," + pr{2}+")")
end

function test_proximate_to(tc, pp)

tc.verifyEqual(stdlib.proximate_to(pp{1}, pp{2}), pp{3}, ...
  "proximate_to(" + pp{1} + ", " + pp{2}+")")
end

end
end


function p = init_rel()

root = fileparts(fileparts(mfilename('fullpath')));

p = {{"", "", ""}, ...
{pwd(), pwd(), "."}, ...
{fileparts(pwd()), pwd(), "test"}, ...
{root, fullfile(root, "test", mfilename() + ".m"), fullfile("test", mfilename + ".m")}
};
% NOTE: ".." in relative_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc.

% if stdlib.has_python() || stdlib.has_dotnet()
% p = [p, {
% {"a/b/c/d", "a/b", fullfile("..", "..")}, ...
% {"a/b", "a/c", fullfile("..", "c")}, ...
% {"a/b", "c", fullfile("..", "..", "c")}, ...
% {"c", "a/b", fullfile("..", "a", "b")}, ...
% {"a/b", "a", ".."}, ...
%   }];
% end

if ispc()

% if stdlib.has_python() || stdlib.has_dotnet()
% p = [p, { ...
% {"C:/a/b", "C:/", fullfile("..", "..")}, ...
% {"c:/a/b", "c:/a", ".."}, ...
% {"c:\a/b\c/d", "c:/a\b", fullfile("..", "..")}
%   }];
% end

% p = [p, {
% {"C:/", "C:/a/b", fullfile("a", "b")}, ...
% {"c:/a/b", "c:/a/b", "."}, ...
% {"C:/path", "D:\path", ""}, ...
% {"D:/a/b", "c", ""}}];
% % note: on Windows the drive letter should be uppercase!

else

p = [p, {
{"/", "/", "."}, ...
{"/dev/null", "/dev/null", "."}, ...
}];
end

end

function p = init_prox()
% NOTE: ".." in proximate_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc

p = init_rel();

end
