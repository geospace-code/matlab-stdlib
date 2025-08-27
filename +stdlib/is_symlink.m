%% IS_SYMLINK is path a symbolic link
%
%%% inputs
% * file: path to check
% * backend: backend to use
%%% Outputs
% * ok: true if path is a symbolic link
% * b: backend used

function [ok, b] = is_symlink(file, backend)
arguments
  file string
  backend (1,:) string = ["native", "java", "python", "dotnet", "sys"]
end

o = stdlib.Backend(mfilename(), backend);

if isscalar(file)
  ok = o.func(file);
else
  ok = arrayfun(o.func, file);
end

b = o.backend;

end
