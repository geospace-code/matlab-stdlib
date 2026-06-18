%% RAM_FREE get free physical RAM
% What 'free' memory means has many definitions across computing platforms.
% The user must consider total memory and monitor swap usage.
%
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Inputs
% * backend: backend to use
%%% Outputs
% * i: free physical RAM [bytes]
% * b: backend used


function [i, b] = ram_free(backend)
arguments
  backend (1,:) string = ["java", "python", "shell"]
end

i = uint64([]);

for b = backend
  switch b
    case 'java'
      i = stdlib.java.ram_free();
    case 'python'
      if stdlib.has_python()
        i = stdlib.python.ram_free();
      end
    case 'shell'
      i = stdlib.shell.ram_free();
    otherwise
      error('stdlib:ram_free:ValueError', 'Unknown backend: %s', b)
  end

  if ~isempty(i)
    return
  end
end

% * VisualBasic (needs Windows) is needed to do this with .NET.
% * builtin memory() on Windows includes swap. The user could do that themselves.

end

%!assert (stdlib.ram_free() > 0)
