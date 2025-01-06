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

function r = resolve(p, expand_tilde)
arguments
  p (1,1) string
  expand_tilde (1,1) logical = true
end


r = stdlib.canonical(stdlib.absolute(p, "", expand_tilde), false);

end

%!assert (resolve('', 1), stdlib.posix(pwd()))
