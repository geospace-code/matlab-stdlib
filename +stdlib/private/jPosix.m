function s = jPosix(o)

  d = "";

  if isempty(o)
    s = "";
  else
    s = o.toString();
  end

  if isa(d, "string")
    s = string(s);
  end

  s = stdlib.posix(s);

end
