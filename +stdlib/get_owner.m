%% GET_OWNER owner name of file or directory
%
%%% Inputs
% * file: path to examine
% * backend: backend to use
%%% Outputs
% * r: owner, or empty if path does not exist
% * b: backend used

function [r, b] = get_owner(file, backend)
if nargin < 2
  backend = {'java', 'dotnet', 'python', 'sys'};
else
  backend = cellstr(backend);
end

r = '';

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'java'
      r = stdlib.java.get_owner(file);
    case 'dotnet'
      r = stdlib.dotnet.get_owner(file);
    case 'python'
      if stdlib.has_python()
        r = stdlib.python.get_owner(file);
      end
    case 'sys'
      r = stdlib.sys.get_owner(file);
    otherwise
      error('stdlib:get_owner:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(r)
    return
  end
end

end


%!assert (~isempty(stdlib.get_owner('.')))
