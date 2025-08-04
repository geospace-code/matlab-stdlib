%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p, backend)
arguments
  p string
  backend = 'pattern'
end

% the pattern backend is a few percent faster than regexp
switch backend
  case 'pattern'
    f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep)));
  case 'regexp'
    f = regexp(p, ['[^/\' filesep ']*$'], 'match', 'once');
    f(ismissing(f)) = "";
  otherwise, error('must be backend "pattern" or "regexp"')
end

end
