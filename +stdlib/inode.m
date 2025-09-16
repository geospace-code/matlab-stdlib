%% INODE filesystem inode of path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: inode number
% * b: backend used

function [i, b] = inode(file, backend)
if nargin < 2
  backend = ["java", "python", "sys"];
else
  backend = string(backend);
end

i = uint64.empty;

for b = backend
  switch b
    case "java"
      i = stdlib.java.inode(file);
    case "python"
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.inode(file);
    case "sys"
      i = stdlib.sys.inode(file);
    otherwise
      error("stdlib:inode:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end
