%% PARENT parent directory of path
%
%% Examples:
% stdlib.parent("a/b/c") == "a/b"
% stdlib.parent("a/b/c/") == "a/b"

function p = parent(pth, backend)
arguments
  pth {mustBeTextScalar}
  backend (1,:)string = ["java", "python", "native"]
end

fun = hbackend(backend, "parent");

p = fun(pth);

end
