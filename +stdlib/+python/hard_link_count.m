function c = hard_link_count(file)

if stdlib.has_python()
  c = double(py.os.stat(file).st_nlink);
else
  c = missing;
end

end
