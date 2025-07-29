%% PARENT parent directory of path
%
%% Examples:
% stdlib.parent("a/b/c") == "a/b"
% stdlib.parent("a/b/c/") == "a/b"

function p = parent(pth, method)
arguments
  pth {mustBeTextScalar}
  method (1,:) string = ["java", "python", "native"]
end

fun = choose_method(method, "parent");

p = fun(pth);

end
