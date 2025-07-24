function f = disk_capacity(d)

di = py.shutil.disk_usage(d);

f = int64(di.total);
% int64 first is for Matlab <= R2022a

end
