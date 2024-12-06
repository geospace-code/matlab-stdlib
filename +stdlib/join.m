%% JOIN join two paths with posix file separator

function p = join(base, other, use_java)
arguments
  base (1,1) string
  other (1,1) string
  use_java (1,1) logical = false
end

if base == "" && other == ""
  p = "";
  return
end

b = stdlib.drop_slash(base);
o = stdlib.drop_slash(other);

if b == ""
  p = o;
  return
end

if o == ""
  p = b;
  return
end


if use_java

p = java.io.File(b).toPath().resolve(o);

else

if startsWith(o, "/") || (ispc && stdlib.is_absolute(o))
  p = o;
  return
end

p = b + "/" + o;

end

end
