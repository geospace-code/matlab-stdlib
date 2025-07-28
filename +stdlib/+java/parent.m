function p = parent(pth)

p = javaObject("java.io.File", pth).getParent();
if isempty(p)
  rn = stdlib.root_name(pth);
  if ispc() && ~stdlib.strempty(pth) && ~stdlib.strempty(rn) && startsWith(pth, rn)
    p = strcat(rn, filesep);
  else
    p = ".";
  end
else
  p = string(p);
end

end
