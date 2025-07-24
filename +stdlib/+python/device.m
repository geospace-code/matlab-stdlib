function i = device(p)

i = uint64(int64(py.os.stat(p).st_dev));
% int64 first is for Matlab <= R2022a

end
