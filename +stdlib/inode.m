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
  backend = {'java', 'python', 'sys'};
else
  backend = cellstr(backend);
end

i = uint64([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      i = stdlib.java.inode(file);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.inode(file);
      end
    case 'sys'
      i = stdlib.sys.inode(file);
    otherwise
      error('stdlib:inode:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end


%!assert (stdlib.inode('.') > 0)
