function n = normalize(file)
arguments
  file (1,1) string
end

n = string(javaPathObject(file).normalize());

if stdlib.strempty(n)
  n = ".";
else
  n = strip(n, 'right', '/');
  if ispc()
    n = strip(n, 'right', filesep);
  end
end

end
