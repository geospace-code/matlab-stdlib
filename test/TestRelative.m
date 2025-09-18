classdef (SharedTestFixtures={ matlab.unittest.fixtures.PathFixture(fileparts(fileparts(mfilename('fullpath'))))}, ...
          TestTags = {'R2017a', 'pure'}) ...
    TestRelative < matlab.unittest.TestCase


properties (TestParameter)
pr = init_rel();
end


methods (Test)

function test_relative_to(tc, pr)
r = stdlib.relative_to(pr{1}, pr{2});
tc.verifyEqual(r, pr{3}, [pr{1} ' ' pr{2}])

r = stdlib.relative_to(string(pr{1}), pr{2});
tc.verifyEqual(r, string(pr{3}))
end

function test_proximate_to(tc, pr)
r = stdlib.proximate_to(pr{1}, pr{2});
tc.verifyEqual(r, pr{3}, [pr{1} ' ' pr{2}])

r = stdlib.proximate_to(string(pr{1}), pr{2});
tc.verifyEqual(r, string(pr{3}))
end

end
end


function pr = init_rel()

pr = {{'', '', ''}, ...
{pwd(), pwd(), '.'}, ...
{fileparts(pwd()), pwd(), 'test'}
};


root = fileparts(fileparts(mfilename('fullpath')));
if ~isempty(root)
  pr{end+1} = {root, fullfile(root, 'test', [mfilename(), '.m']), ...
                     fullfile('test', [mfilename, '.m'])};
end


% NOTE: '..' in relative_to(base) is ambiguous including for python.pathlib, C++ <filesystem>, etc.

% if stdlib.has_python() || stdlib.has_dotnet()
% p = [p, {
% {'a/b/c/d', 'a/b', fullfile('..', '..')}, ...
% {'a/b', 'a/c', fullfile('..', 'c')}, ...
% {'a/b', 'c', fullfile('..', '..', 'c')}, ...
% {'c', 'a/b', fullfile('..', 'a', 'b')}, ...
% {'a/b', 'a', '..'}, ...
%   }];
% end

if ispc()

% if stdlib.has_python() || stdlib.has_dotnet()
% p = [p, { ...
% {'C:/a/b', 'C:/', fullfile('..', '..')}, ...
% {'c:/a/b', 'c:/a', '..'}, ...
% {'c:\a/b\c/d', 'c:/a\b', fullfile('..', '..')}
%   }];
% end

% p = [p, {
% {'C:/', 'C:/a/b', fullfile('a', 'b')}, ...
% {'c:/a/b', 'c:/a/b', '.'}, ...
% {'C:/path', 'D:\path', ''}, ...
% {'D:/a/b', 'c', ''}}];
% % note: on Windows the drive letter should be uppercase!

else

pr = [pr, {
{'/', '/', '.'}, ...
{'/dev/null', '/dev/null', '.'}, ...
}];
end
end
