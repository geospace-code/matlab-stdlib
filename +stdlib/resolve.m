%% RESOLVE resolve path
% resolve path, to cwd if relative
% effectively canonical(absolute(p))
%%% Inputs
% * p: path to make absolute
% * expand_tilde: expand ~ to username if present
%%% Outputs
% * c: resolved path
% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd

function r = resolve(p, expand_tilde, use_java)
arguments
  p (1,1) string
  expand_tilde (1,1) logical = true
  use_java (1,1) logical = false
end

r = stdlib.canonical(stdlib.absolute(p, string.empty, expand_tilde, use_java), false, use_java);

end
