%% INODE filesystem inode of path
%
%% Inputs
% * file: path to check
%% Outputs
% * i: inode number
% * b: backend used

function [i, b] = inode(file, backend)
arguments
  file {mustBeTextScalar}
  backend (1,:) string = ["java", "python", "sys"]
end

[fun, b] = hbackend(backend, "inode");

i = fun(file);

end
