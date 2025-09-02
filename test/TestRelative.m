classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2021a', 'pure'}) ...
    TestRelative < matlab.unittest.TestCase


properties (TestParameter)
pr
backend
end


methods (TestParameterDefinition, Static)

function pr = init_rel()

root = fileparts(fileparts(mfilename('fullpath')));

pr = {{"", "", ""}, ...
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

pr = [pr, {
{"/", "/", "."}, ...
{"/dev/null", "/dev/null", "."}, ...
}];
end
end

function backend = setupBackends()
backend = init_backend("relative_to");
end
end


methods (Test)

function test_relative_to(tc, pr, backend)
r = stdlib.relative_to(pr{1}, pr{2}, backend);

tc.verifyEqual(r, pr{3}, "relative_to(" + pr{1} + "," + pr{2}+")")
end

function test_proximate_to(tc, pr, backend)
r = stdlib.proximate_to(pr{1}, pr{2}, backend);

tc.verifyEqual(r, pr{3}, "proximate_to(" + pr{1} + ", " + pr{2}+")")
end

end
end
