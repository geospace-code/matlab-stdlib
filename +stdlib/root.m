function r = root(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
  r = string(java.io.File(p).toPath().getRoot());
else

  r = "";

  if startsWith(p, "/")
    r = "/";
  elseif ispc && strlength(p) >= 2 && isletter(extractBetween(p, 1, 1)) && extractBetween(p, 2, 2) == ":"
    r = extractBetween(p, 1, 2) + "/";
  end

end

end
