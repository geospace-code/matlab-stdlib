%% PARENT parent directory of path
%
%%% inputs
% * file: path to file or folder
%%% Outputs
% * par: parent directory of path
%% Examples:
% stdlib.parent("a/b/c") == "a/b"
% stdlib.parent("a/b/c/") == "a/b"

function p = parent(file)
arguments
  file (1,1) string
end

p = fileparts(stdlib.drop_slash(file));

if stdlib.strempty(p)
  p = ".";
elseif ispc() && p == stdlib.root_name(file)
  p = p + "/";
end

end
