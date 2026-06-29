%% INODE filesystem inode of path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: inode number - may be uint64 or string if larger than 64 bits
% * b: backend used

function [i, b] = inode(file, backend)
arguments
  file (1,1) string {mustBeFileOrFolder}
  backend (1,:) string {mustBeNonempty} = ["java", "python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".inode");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
