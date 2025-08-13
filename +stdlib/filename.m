%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p, backend)
arguments
  p string
  backend = 'fileparts'
end

% the pattern backend is a litle slower than
% fileparts is 5x to 10x faster than regexp and pattern
switch backend
  case 'fileparts'
    [~, f, ext] = fileparts(p);
    f = f + ext;
  case 'pattern'
    f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep)));
  case 'regexp'
    f = regexp(p, ['[^/\' filesep ']*$'], 'match', 'once');
    f(ismissing(f)) = "";
  otherwise, error('must be backend "pattern", "regexp" or "fileparts"')
end

end
