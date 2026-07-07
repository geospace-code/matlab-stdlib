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
  backend (1,:) string {mustBeNonempty} = ["java", "python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".ram_free");
  i = f();

  if ~ismissing(i)
    return
  end
end

% * VisualBasic (needs Windows) is needed to do this with .NET.
% * builtin memory() on Windows includes swap. The user could do that themselves.

end
