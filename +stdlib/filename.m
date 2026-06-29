%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p, backend)
arguments
  p {mustBeTextScalar}
  backend {mustBeTextScalar} = 'fileparts'
end

% fileparts is 5x to 10x faster than regexp and pattern
switch backend
  case 'fileparts'
    [~, f, ext] = fileparts(p);
    f = stdlib.append(f, ext);
% the pattern backend is a little slower than regexp.
  case 'pattern'
    f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep)));
  case 'regexp'
    i = regexp(p, ['[^/\' filesep ']*$'], 'once');
    if isempty(i)
      f = extractBefore(p, 1);
    else
      f = extractAfter(p, i-1);
    end
  otherwise
    error('must be backend "regexp" or "fileparts"')
end

end
