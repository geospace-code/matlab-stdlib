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
  file (1,1) string {mustBeFolder}
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".disk_available");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
