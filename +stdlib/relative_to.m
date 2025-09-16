%% RELATIVE_TO relative path to target from base
%
%%% Inputs
% * base: directory to which the other path should be relative
% * target: path to be made relative
%%% Outputs
% * rel: relative path from base to target
%
% Note: Java Path.relativize has an algorithm so different that we choose not to use it.
% javaPathObject(base).relativize(javaPathObject(target))
% https://docs.oracle.com/javase/8/docs/api/java/nio/file/Path.html#relativize-java.nio.file.Path-

function rel = relative_to(base, target)
% arguments
%   base (1,1) string
%   target (1,1) string
% end

% matlab.io.internal.filesystem.relativepath only works on Windows (!) and only
% then with / filesep.

if stdlib.strempty(base) || stdlib.strempty(target)
  if isstring(base) || isstring(target)
    rel = "";
  else
    rel = '';
  end
  return
end

fs = ["/", filesep];

tp = split(fullfile(char(target)), fs);
bp = split(fullfile(char(base)), fs);

% Find the common base portion
n = 0;
while n < length(tp) && n < length(bp) && strcmp(tp{n+1}, bp{n+1})
  n = n + 1;
end

if n+1 <= length(tp)
  rel = join(tp(n+1:end), filesep);
  if iscell(rel)
    rel = rel{1};
  end
else
  rel = '.';
end

if isstring(base) || isstring(target)
  rel = string(rel);
end

end
