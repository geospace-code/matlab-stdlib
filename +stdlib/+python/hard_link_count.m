function c = hard_link_count(p)

try
  c = double(py.os.stat(p).st_nlink);
catch e
  c = [];
end

end
