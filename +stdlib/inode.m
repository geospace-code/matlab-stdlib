%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(file, method)
arguments
  file {mustBeTextScalar}
  method (1,:) string = ["java", "python", "sys"]
end

fun = choose_method(method, "inode");
i = fun(file);

end

%!assert(inode(pwd) >= 0);
%!assert(isempty(inode(tempname())));
