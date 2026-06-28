function y = is_dev_drive(fpath)
% https://github.com/python/cpython/blob/9ee0214b5dd982ac9fbe18dcce0e8787456e29af/Modules/posixmodule.c#L4916

y = missing;

if ~ispc() && stdlib.has_python()
  pyv = stdlib.python.version();
  if all(pyv(1:2) > [3, 12])
    y = py.os.path.isdevdrive(fpath);
  end
end

end
