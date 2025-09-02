function n = normalize(file)

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
