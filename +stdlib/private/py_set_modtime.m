function ok = py_set_modtime(p, utc)

try
  s = py.os.stat(p);
  py.os.utime(p, py.tuple(s.st_atime, utc));
  ok = true;
catch e
  warning(e.identifier, "%s", e.message)
  ok = false;
end

end
