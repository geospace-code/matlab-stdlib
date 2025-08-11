%% PARENT parent directory of path
%
%% Inputs
% * file: path to file or folder
% * backend: backend to use
%% Outputs
% * par: parent directory of path
% * b: backend used
%% Examples:
% stdlib.parent("a/b/c") == "a/b"
% stdlib.parent("a/b/c/") == "a/b"

function [par, b] = parent(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "python", "native"]
end

if isscalar(file)
  [fun, b] = hbackend(backend, "parent");
  par = fun(file);
else
  b = "native";
  par = stdlib.native.parent(file);
end

end
