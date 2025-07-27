%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(p)
arguments
  p {mustBeTextScalar}
end

i = [];

if stdlib.has_python()
  i = stdlib.python.inode(p);
elseif isunix() && stdlib.has_java()
  i = stdlib.java.inode(p);
end

if isempty(i)
  i = stdlib.sys.inode(p);
end

end

%!assert(inode(pwd) >= 0);
%!assert(isempty(inode(tempname())));
