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
arguments
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".ram_total");
  i = f();

  if ~ismissing(i)
    return
  end
end

end
