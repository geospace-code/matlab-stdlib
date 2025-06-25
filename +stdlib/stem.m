%% STEM filename without directory or suffix

function st = stem(p)
arguments
  p {mustBeTextScalar}
end

[~, n, s] = fileparts(p);

if strempty(n)
  st = s;
else
  st = n;
end

end

%!assert(stem('/a/b.c'), 'b')
%!assert(stem("a/b/.c"), ".c")
