%% DEVICE filesystem device index of path
%
%%% Inputs
% * file: path to file
% * backend: backend to use
%%% Outputs
% * i: device index
% * b: backend used

function [i, b] = device(file, backend)
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
      i = stdlib.java.device(file);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.device(file);
    case 'sys'
      i = stdlib.sys.device(file);
    otherwise
      error('stdlib:device:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end


%!assert (stdlib.device('.') > 0)
