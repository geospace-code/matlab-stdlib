%% NATIVE.SAMEPATH are two paths equivalent
%
% this canonical string method is less preferred to using device + inode.

function y = samepath(path1, path2)

c1 = stdlib.canonical(path1, true);
c2 = stdlib.canonical(path2, true);

y = strlength(c1) && strcmp(c1, c2);

end
