%% INODE filesystem inode of path
%
%% Inputs
% * file: path to check
%% Outputs
% * i: inode number
% * b: backend used

function [i, b] = inode(file, backend)
arguments
  file string
  backend (1,:) string = ["java", "python", "perl", "sys"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  i = o.func(file);
else
  i = arrayfun(o.func, file);
end

b = o.backend;

end
