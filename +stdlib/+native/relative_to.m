%% NATIVE.RELATIVE_TO find relative path to target from base

function rel = relative_to(base, target)
arguments
  base (1,1) string
  target (1,1) string
end
% matlab.io.internal.filesystem.relativepath only works on Windows (!) and only
% then with / filesep.

if stdlib.strempty(base) || stdlib.strempty(target)
  rel = "";
  return
end

tp = strsplit(fullfile(target), filesep);
bp = strsplit(fullfile(base), filesep);

% Find the common base portion
n = 0;
while n < length(tp) && n < length(bp) && strcmp(tp{n+1}, bp{n+1})
  n = n + 1;
end

% Number of '..' needed
numUp = length(bp) - n;

relParts = [repmat({'..'}, 1, numUp), tp(n+1:end)];

if isempty(relParts)
  rel = '.';
else
  rel = fullfile(relParts{:});

  if isempty(rel)
    rel = '.';
  end
end

rel = string(rel);

end
