%% SUFFIX last suffix of filename

function s = suffix(p)
arguments
  p string
end

pat = textBoundary("start") + asManyOfPattern(wildcardPattern + ".", 1);

s = extractAfter(p, pat);

i = ~ismissing(s);
s(~i) = "";

s(i) = strcat('.', s(i));

end
