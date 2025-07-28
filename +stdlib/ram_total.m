%% RAM_TOTAL get total physical RAM
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

function bytes = ram_total()

if stdlib.dotnet_api() >= 6
  bytes = stdlib.dotnet.ram_total();
elseif stdlib.has_java()
  bytes = stdlib.java.ram_total();
elseif stdlib.python.has_psutil()
  bytes = stdlib.python.ram_total();
else
  bytes = stdlib.sys.ram_total();
end

end

%!assert(ram_total()>0)
