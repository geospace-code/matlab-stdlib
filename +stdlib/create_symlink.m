%% CREATE_SYMLINK create symbolic link
%
%%% inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * i: true if successful
% * b: backend used

function [i, b] = create_symlink(target, link, backend)
if nargin < 3
  backend = {'native', 'dotnet', 'python', 'sys'};
else
  backend = cellstr(backend);
end

i = logical([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'native'
      i = stdlib.native.create_symlink(target, link);
    case 'dotnet'
      i = stdlib.dotnet.create_symlink(target, link);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.create_symlink(target, link);
      end
    case 'sys'
      i = stdlib.sys.create_symlink(target, link);
    otherwise
      error('stdlib:create_symlink:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end
