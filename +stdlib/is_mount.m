%% IS_MOUNT is filepath a mount path
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * ok: true if path is a mount point
% * b: backend used
%
% Examples:
%
% * Windows: is_mount('c:') false;  is_mount('C:\') true
% * Linux, macOS, Windows: is_mount('/') true

function [i, b] = is_mount(file, backend)
arguments
  file (1,1) string {mustBeFolder}
  backend (1,:) string {mustBeNonempty} = ["python", "shell"]
end

i = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".is_mount");
  i = f(file);

  if ~ismissing(i)
    return
  end
end

end
