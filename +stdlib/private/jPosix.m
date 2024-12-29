function s = jPosix(o)

  if isempty(o)
    s = "";
  else
    s = o.toString();
  end

  s = stdlib.posix(s);

end
