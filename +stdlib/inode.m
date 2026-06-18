%% INODE filesystem inode of path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * i: inode number
% * b: backend used

function [i, b] = inode(file, backend)
arguments
  file {mustBeTextScalar, mustBeFileOrFolder}
  backend (1,:) string = ["java", "python", "shell"]
end

i = uint64([]);

for b = backend
  switch b
    case 'java'
      i = stdlib.java.inode(file);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.inode(file);
      end
    case 'shell'
      i = stdlib.shell.inode(file);
    otherwise
      error('stdlib:inode:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end


%!assert (stdlib.inode('.') > 0)
