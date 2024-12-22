%% STEM filename without directory or suffix

function st = stem(p)
arguments
  p (1,1) string
end

[~, n, s] = fileparts(p);

if stdlib.len(n)
  st = n;
else
  st = s;
end

end

%!assert(stem('/a/b.c'), 'b')
%!assert(stem("a/b/.c"), ".c")
