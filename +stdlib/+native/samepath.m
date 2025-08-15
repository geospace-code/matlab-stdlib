%% NATIVE.SAMEPATH are two paths equivalent
%
% this canonical string method is less preferred to using device + inode.

function y = samepath(path1, path2)
arguments
  path1 string
  path2 string
end

assert(isequal(size(path1), size(path2)), "path1 string array size does not match path2 array size")

y = false(size(path1));

y(strlength(path1) | strlength(path2)) = true;

% necessary for Matlab < R2024a
if ~any(y)
  return
end

c1 = stdlib.canonical(path1(y), true);
c2 = stdlib.canonical(path2(y), true);
y(y) = strlength(c1) & strcmp(c1, c2);

end
