function c = py_hard_link_count(p)

c = double(py.os.stat(p).st_nlink);

end
