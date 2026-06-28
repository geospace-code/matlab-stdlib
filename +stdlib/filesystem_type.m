%% FILESYSTEM_TYPE tell type of filesystem
%
% example outputs: NTFS, ext4, apfs, ...
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * r: filesystem type
% * b: backend used

function [r, b] = filesystem_type(file, backend)
arguments
  file (1,1) string {mustBeFolder}
  backend (1,:) string {mustBeNonempty} = ["java", "dotnet", "python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".filesystem_type");
  r = f(file);

  if ~ismissing(r)
    return
  end
end

end
