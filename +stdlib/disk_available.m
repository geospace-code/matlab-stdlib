%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
%% Inputs
% * filepath: path to check
%% Outputs
% * f: free disk space (bytes)
% * b: backend used
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function [f, b] = disk_available(filepath, backend)
arguments
  filepath {mustBeTextScalar}
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

[fun, b] = hbackend(backend, "disk_available");

f = fun(filepath);

end
