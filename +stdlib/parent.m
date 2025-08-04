%% PARENT parent directory of path
%
%% Examples:
% stdlib.parent("a/b/c") == "a/b"
% stdlib.parent("a/b/c/") == "a/b"

function par = parent(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "python", "native"]
end

if isscalar(file)
  fun = hbackend(backend, "parent");
  par = fun(file);
else
  par = stdlib.native.parent(file);
end

end
