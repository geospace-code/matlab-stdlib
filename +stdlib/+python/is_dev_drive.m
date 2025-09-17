function y = is_dev_drive(fpath)
% https://github.com/python/cpython/blob/9ee0214b5dd982ac9fbe18dcce0e8787456e29af/Modules/posixmodule.c#L4916
try
  y = py.os.path.isdevdrive(fpath);
catch
  y = logical([]);
end

end
