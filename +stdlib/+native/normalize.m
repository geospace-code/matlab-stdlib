%% NATIVE.NORMALIZE normalize path
% 2-3x as fast as non-native backends

function n = normalize(apath)
arguments
  apath (1,1) string
end

parts = split(apath, ["/", filesep]);
i0 = 1;
if startsWith(apath, "/" | filesep)
  n = extractBefore(apath, 2);
elseif ispc() && strlength(apath) >= 2 && ~stdlib.strempty(stdlib.root_name(apath))
  n = parts(1);
  i0 = 2;
else
  n = "";
end

for i = i0:length(parts)
  if ~ismember(parts(i), [".", ""])
    if n == ""
      n = parts(i);
    elseif ismember(n, ["/", filesep])
      n = n + parts(i);
    else
      n = n + "/" + parts(i);
    end
  end
end

if stdlib.strempty(n)
  n = ".";
end

end
