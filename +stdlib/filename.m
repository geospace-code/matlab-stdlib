%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p, method)
arguments
  p string
  method = 'pattern'
end

% the pattern method is a few percent faster than regexp  
switch method
  case 'pattern'
    f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep)));
  case 'regexp'
    f = regexp(p, ['[^/\' filesep ']*$'], 'match', 'once');
    f(ismissing(f)) = "";
    otherwise, error('must be method "pattern" or "regexp"')
end

end
