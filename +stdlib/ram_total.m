%% RAM_TOTAL get total physical RAM
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

function bytes = ram_total()

bytes = 0;

if stdlib.dotnet_api() >= 6
  bytes = stdlib.dotnet.ram_total();
elseif stdlib.has_java()
  bytes = stdlib.java.ram_total();
end

if bytes <= 0
  bytes = stdlib.sys.ram_total();
end

bytes = uint64(bytes);

end


%!assert(ram_total()>0)
