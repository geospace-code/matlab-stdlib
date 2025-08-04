%% INODE filesystem inode of path
%
% Windows always returns 0, Unix returns inode number.

function i = inode(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "sys"]
end

fun = hbackend(backend, "inode");
i = fun(file);

end
