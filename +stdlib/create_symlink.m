%% CREATE_SYMLINK create symbolic link
%
%%% inputs
% * target: path to link to
% * link: path to create link at
%%% Outputs
% * i: true if successful
% * b: backend used

function [i, b] = create_symlink(target, link, backend)
arguments
  target {mustBeTextScalar}
  link {mustBeTextScalar}
  backend (1,:) string = ["native", "dotnet", "python", "shell"]
end

i = missing;

for b = backend
  switch b
    case 'native'
      i = stdlib.native.create_symlink(target, link);
    case 'dotnet'
      i = stdlib.dotnet.create_symlink(target, link);
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.create_symlink(target, link);
      end
    case 'shell'
      i = stdlib.shell.create_symlink(target, link);
    otherwise
      error('stdlib:create_symlink:ValueError', 'Unknown backend: %s', b)
  end

  if ~ismissing(i)
    return
  end
end

end
