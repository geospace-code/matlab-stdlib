%% JOIN join two paths with posix file separator

function p = join(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end

rno = stdlib.root_name(other);
rnb = stdlib.root_name(base);
rdo = stdlib.root_dir(other);

if stdlib.is_absolute(other) || (~strempty(rno) && ~strcmp(rnb, rno))

  p = other;

elseif ~strempty(rdo)

  if ~strempty(rnb)
    p = fullfile(rnb, other);
  else
    p = other;
  end

elseif ~strempty(base)

  if ~strempty(other)
    p = fullfile(base, other);
  else
    p = base;
  end

else

  p = other;

end

end

%!assert(join("", ""), "")
%!assert(join("", "b"), "b")
%!assert(join("a", ""), "a")
%!assert(join("a", "b"), fullfile("a", "b"))
%!assert(join("a", "/b/c"), "/b/c")
