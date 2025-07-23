function f = py_disk_available(d)

di = py.shutil.disk_usage(d);

f = int64(di.free);
% int64 first is for Matlab <= R2022a

end
