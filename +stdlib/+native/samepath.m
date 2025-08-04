%% NATIVE.SAMEPATH are two paths equivalent
%
% this canonical string method is less preferred to using device + inode.

function y = samepath(path1, path2)

i = stdlib.strempty(path1) | stdlib.strempty(path2);
y(i) = false;

c1 = stdlib.canonical(path1(~i), true);
c2 = stdlib.canonical(path2(~i), true);
y(~i) = ~stdlib.strempty(c1) & strcmp(c1, c2);

end
