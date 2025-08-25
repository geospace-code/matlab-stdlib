function c = hard_link_count(file)

try
  c = double(py.os.stat(file).st_nlink);
catch e
  c = [];
end

end
