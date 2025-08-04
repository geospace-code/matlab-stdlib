%% RESOLVE resolve path
% resolve path, to cwd if relative
% effectively canonical(absolute(p))
%%% Inputs
% * p: path to make absolute
%%% Outputs
% * c: resolved path
% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd

function r = resolve(p)
arguments
  p string
end

r = stdlib.canonical(stdlib.absolute(p));

end
