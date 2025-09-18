%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
%%% inputs
% * file: path to check
%%% Outputs
% * f: free disk space (bytes)
% * b: backend used
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function [i, b] = disk_available(file, backend)
if nargin < 2
  backend = {'java', 'dotnet', 'python', 'sys'};
else
  backend = cellstr(backend);
end

i = uint64([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'dotnet'
      i = stdlib.dotnet.disk_available(file);
    case 'java'
      i = stdlib.java.disk_available(file);
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.disk_available(file);
    case 'sys'
      i = stdlib.sys.disk_available(file);
    otherwise
      error('stdlib:disk_available:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

end

%!test
%! addpath([pwd() '/+dotnet/private'])
%!assert (stdlib.disk_available('.') > 0)
