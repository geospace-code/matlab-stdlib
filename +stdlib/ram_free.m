%% RAM_FREE get free physical RAM
% What "free" memory means has many definitions across computing platforms.
% The user must consider total memory and monitor swap usage.
%
% get free physical RAM across operating systems
% https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html#getFreeMemorySize()
%
%%% Inputs
% * backend: backend to use
%%% Outputs
% * freebytes: free physical RAM [bytes]
% * b: backend used
%
% Java or Python psutil are consistent with each other.
%
% Fallback is to shell commands.

function [bytes, b] = ram_free(backend)
arguments
  backend (1,:) string = ["java", "python", "sys"]
end

[fun, b] = hbackend(backend, "ram_free");

bytes = fun();

% * VisualBasic (needs Windows) is needed to do this with .NET.
% * builtin memory() on Windows includes swap. The user could do that themselves.

end
