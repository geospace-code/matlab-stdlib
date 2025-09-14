function c = hard_link_count(file)

try
  c = double(py.os.stat(file).st_nlink);
catch e
  pythonException(e)
  c = [];
end

end
