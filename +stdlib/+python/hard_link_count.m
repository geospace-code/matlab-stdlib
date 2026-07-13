function c = hard_link_count(file)

c = double(py.os.stat(file).st_nlink);

end
