%% JOIN join two paths with posix file separator

function p = join(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end

rno = stdlib.root_name(other);
rnb = stdlib.root_name(base);
rdo = stdlib.root_dir(other);

if stdlib.is_absolute(other) || (strlength(rno) && ~strcmp(rnb, rno))

  p = other;

elseif strlength(rdo)

  if strlength(rnb)
    p = strcat(rnb, '/', other);
  else
    p = other;
  end

elseif strlength(base)

  if strlength(other)
    if endsWith(base, {'/', filesep})
      p = strcat(base, other);
    else
      p = strcat(base, '/', other);
    end
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
%!assert(join("a", "b"), "a/b")
%!assert(join("a", "/b/c"), "/b/c")
