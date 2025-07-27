%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(p)
arguments
  p {mustBeTextScalar}
end

if isunix() && stdlib.has_java()
  i = stdlib.java.inode(p);
elseif stdlib.has_python()
  i = stdlib.python.inode(p);
else
  i = stdlib.sys.inode(p);
end

end

%!assert(inode(pwd) >= 0);
%!assert(isempty(inode(tempname())));
