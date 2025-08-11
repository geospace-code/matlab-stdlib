%% RESOLVE resolve path
% resolve path, to cwd if relative
% effectively canonical(absolute(p))
%%% Inputs
% * p: path to make absolute
% * backend: backend to use
%%% Outputs
% * c: resolved path
% * b: backend used

% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd

function [r, b] = resolve(p, strict, backend)
arguments
  p string
  strict (1,1) logical = false
  backend (1,:) string = ["native", "legacy"]
end

[r, b] = stdlib.canonical(stdlib.absolute(p), strict, backend);

end
