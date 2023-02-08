function ppath = posix(file)

arguments
  file string
end


ppath = fullfile(file);

if ispc
  ppath = strrep(ppath, "\", "/");
end

end
