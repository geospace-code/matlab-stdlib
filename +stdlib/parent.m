%% PARENT parent directory of path
%
%% Inputs
% * file: path to file or folder
%% Outputs
% * par: parent directory of path
%% Examples:
% stdlib.parent("a/b/c") == "a/b"
% stdlib.parent("a/b/c/") == "a/b"

function p = parent(file)
arguments
  file string
end

p = fileparts(stdlib.drop_slash(file));

i = ~strlength(p);
p(i) = ".";

% the ~all(i) is for Windows Matlab < R2025a
if ispc() && ~all(i)
  i = p(~i) == stdlib.root_name(file(~i));
  p(i) = p(i) + "/";
end

end
