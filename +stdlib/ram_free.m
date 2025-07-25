%% RAM_FREE get free physical RAM
% What "free" memory means has many definitions across computing platforms.
% The user must consider total memory and monitor swap usage.
%
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Outputs
% * freebytes: free physical RAM [bytes]
%
% This is done using Java on non-Windows platforms.
%
% VisualBasic (needs Windows) is needed to do this with .NET,
%
% builtin memory() on Windows includes swap. The user could do that themselves.
%
% we installed use Java or Python psutil, which are consistent with each other.
%
% Fallback is to shell commands.

function bytes = ram_free()

bytes = 0;

if stdlib.has_java()
  bytes = stdlib.java.ram_free();
elseif stdlib.has_python()
  bytes = stdlib.python.ram_free();
end

if bytes <= 0
  bytes = stdlib.sys.ram_free();
end

bytes = uint64(bytes);

end
