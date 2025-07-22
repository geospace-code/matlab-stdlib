%% RAM_TOTAL get total physical RAM
% requires: java
%
% get total physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalPhysicalMemorySize()
%
%%% Outputs
% * bytes: total physical RAM [bytes]

function bytes = ram_total()

bytes = uint64(0);


if ispc() && stdlib.has_dotnet()
  % about the same speed as the Java version below.
  h = NET.addAssembly('Microsoft.VisualBasic');
  ci = Microsoft.VisualBasic.Devices.ComputerInfo();
  bytes = ci.TotalPhysicalMemory;
  delete(h)
elseif stdlib.has_java()
  b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");

  if stdlib.java_api() < 14
    bytes = b.getTotalPhysicalMemorySize();
  else
    bytes = b.getTotalMemorySize();
  end
  bytes = uint64(bytes);
end

% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getTotalMemorySize()

end


%!assert(ram_total()>0)
