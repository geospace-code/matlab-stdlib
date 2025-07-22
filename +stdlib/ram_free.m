%% RAM_FREE get free physical RAM
%
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Outputs
% * freebytes: free physical RAM [bytes]
%
% This is done using Java on non-Windows platforms.
% VisualBasic (needs Windows) is needed to do this with .NET, so we use builtin memory() on Windows.

function bytes = ram_free()

bytes = 0;

try
  % memory() was added cross-platform to Octave ~ 2021.
  % Matlab memory() at least through R2025a is still Windows only.
  m = memory();

  bytes = m.MemAvailableAllArrays;

catch e
  switch e.identifier
    case {'MATLAB:memory:unsupported', 'Octave:undefined-function'}
      if stdlib.has_java()
        bytes = ram_free_java();
      end
    otherwise, rethrow(e)
  end
end

bytes = uint64(bytes);

end


function bytes = ram_free_java()

b = javaMethod("getOperatingSystemMXBean", "java.lang.management.ManagementFactory");

if stdlib.java_api() < 14
  bytes = b.getFreePhysicalMemorySize();
else
  bytes = b.getFreeMemorySize();
end

end

%!assert(ram_free() > 0)
