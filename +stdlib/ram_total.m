%% RAM_TOTAL get total physical RAM
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Inputs
% * backend: backend to use
%%% Outputs
% * bytes: total physical RAM [bytes]
% * b: backend used

function [bytes, b] = ram_total(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "ram_total");

bytes = fun();

end
