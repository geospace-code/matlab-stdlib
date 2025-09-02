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

fs = ["/", filesep];

tp = split(fullfile(target), fs);
bp = split(fullfile(base), fs);

% Find the common base portion
n = 0;
while n < length(tp) && n < length(bp) && strcmp(tp{n+1}, bp{n+1})
  n = n + 1;
end

rel = join(tp(n+1:end), filesep);

if stdlib.strempty(rel)
  rel = ".";
end

end
