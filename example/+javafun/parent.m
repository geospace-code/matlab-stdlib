function par = parent(pth)
arguments
  pth (1,1) string
end

par = java.io.File(pth).getParent();
if isempty(par)
  par = ".";
  if ispc()
    rn = stdlib.root_name(pth);
    if strlength(pth) && strlength(rn) && startsWith(pth, rn)
      par = strcat(rn, filesep);
    end
  end
else
  par = string(par);
end

end
