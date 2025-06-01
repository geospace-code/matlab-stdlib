%% STEM filename without directory or suffix

function st = stem(p)
arguments
  p {mustBeTextScalar}
end

[~, n, s] = fileparts(p);

if strlength(n)
  st = n;
else
  st = s;
end

end

%!assert(stem('/a/b.c'), 'b')
%!assert(stem("a/b/.c"), ".c")
