%% RESOLVE resolve path
% resolve path, to cwd if relative
% effectively canonical(absolute(p))
%%% Inputs
% * file: path to make absolute
% * strict: if true, return empty if path does not exist (default: false)
%%% Outputs
% * c: string: resolved path

% distinct from canonical(), resolve() always returns absolute path
% non-existant path is made absolute relative to pwd

function r = resolve(file, strict)
arguments
  file {mustBeTextScalar}
  strict (1,1) logical = false
end

r = stdlib.canonical(stdlib.absolute(file), strict);

end
