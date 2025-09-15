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

p = fileparts(stdlib.drop_slash(file));

if stdlib.strempty(p)
  p = '.';
  if isstring(file)
    p = string(p);
  end
elseif ispc() && strcmp(p, stdlib.root_name(file))
  p = stdlib.append(p, '/');
end

end
