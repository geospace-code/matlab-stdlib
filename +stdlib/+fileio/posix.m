function p = posix(p)

arguments
  p string
end

if ispc
  p = strrep(p, "\", "/");
end

end
