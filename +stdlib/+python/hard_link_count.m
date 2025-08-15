function c = hard_link_count(file)
arguments
  file (1,1) string
end

try
  c = double(py.os.stat(file).st_nlink);
catch e
  c = [];
end

end
