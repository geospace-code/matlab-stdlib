%% RAM_TOTAL get total physical RAM
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

function bytes = ram_total(backend)
arguments
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

fun = hbackend(backend, "ram_total");

bytes = fun();

end
