%% RAM_TOTAL get total physical RAM
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Inputs
% * backend: backend to use
%%% Outputs
% * i: total physical RAM [bytes]
% * b: backend used

function [i, b] = ram_total(backend)
if nargin < 1
  backend = {'java', 'dotnet', 'python', 'sys'};
else
  backend = string(backend);
end

i = uint64([]);

for j = 1:numel(backend)
  b = backend{j};
  switch b
    case 'dotnet'
      i = stdlib.dotnet.ram_total();
    case 'java'
      i = stdlib.java.ram_total();
    case 'python'
      if stdlib.matlabOlderThan('R2022a'), continue, end
      i = stdlib.python.ram_total();
    case 'sys'
      i = stdlib.sys.ram_total();
    otherwise
      error("stdlib:ram_total:ValueError", "Unknown backend: %s", b)
  end

  if ~isempty(i)
    return
  end
end

end

%!assert (stdlib.ram_total() > 0)