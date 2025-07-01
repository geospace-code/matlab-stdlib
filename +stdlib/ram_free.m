%% RAM_FREE get free physical RAM
% optional: java
%
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Outputs
% * freebytes: free physical RAM [bytes]

function freebytes = ram_free()

try
  % memory() was added cross-platform to Octave ~ 2021.
  % Matlab memory() at least through R2025a is still Windows only.
  m = memory();
  freebytes = m.MemAvailableAllArrays;
catch e
  switch e.identifier
    case {'MATLAB:memory:unsupported', 'Octave:undefined-function'}
      b = javaOSBean();

      if stdlib.java_api() < 14
        freebytes = b.getFreePhysicalMemorySize();
      else
        freebytes = b.getFreeMemorySize();
      end
    otherwise, rethrow(e)
  end
end

end

%!assert(ram_free()>0)
