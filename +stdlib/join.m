%% JOIN join two paths with posix file separator

function p = join(base, other)
arguments
  base (1,1) string
  other (1,1) string
end


b = stdlib.drop_slash(base);
o = stdlib.drop_slash(other);

if strncmp(o, "/", 1) || (ispc && stdlib.is_absolute(o))
  p = o;
  return
end

p = b;
if stdlib.len(o)
  if endsWith(p, "/")
    p = strcat(p, o);
  elseif stdlib.len(p)
    p = strcat(p, "/", o);
  else
    p = o;
  end
end

end

%!assert(join("", ""), "")
%!assert(join("", "b"), "b")
%!assert(join("a", ""), "a")
%!assert(join("a", "b"), "a/b")
%!assert(join("a", "/b/c"), "/b/c")
