%% DISK_AVAILABLE disk available space (bytes)
%
% example:  stdlib.disk_available('/')
%
%%% inputs
% * file: path to check
%%% Outputs
% * f: free disk space (bytes)
% * b: backend used
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getUsableSpace()

function [i, b] = disk_available(file, backend)
arguments
  file
  backend (1,:) string = ["java", "dotnet", "python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
i = o.func(file);

b = o.backend;

end
