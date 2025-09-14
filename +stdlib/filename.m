%% FILENAME file name of path
%
%%% Inputs
% p: path to extract filename from
%%% Outputs
% filename (including suffix) without directory

function f = filename(p, backend)
arguments
  p
  backend = 'fileparts'
end

% fileparts is 5x to 10x faster than regexp and pattern
switch backend
  case 'fileparts'
    [~, f, ext] = fileparts(p);
    f = f + ext;
% the pattern backend is a litle slower than regexp. Commented out for < R2020b compatibility
  % case 'pattern'
  %   f = extractAfter(p, asManyOfPattern(wildcardPattern + ("/" | filesep)));
  case 'regexp'
    f = regexp(p, ['[^/\' filesep ']*$'], 'match', 'once');
    if ismissing(f)
      f = "";
    end
  otherwise, error('must be backend "pattern", "regexp" or "fileparts"')
end

end
