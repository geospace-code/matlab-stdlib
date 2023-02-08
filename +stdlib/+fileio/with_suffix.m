function filename = with_suffix(filename, suffix)

arguments
  filename string
  suffix (1,1) string
end

[direc, name, ext] = fileparts(filename);
if ext ~= suffix
  filename = fullfile(direc, name + suffix);
end

end
