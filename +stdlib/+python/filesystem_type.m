function t = filesystem_type(p)


t = string.empty;

if ~stdlib.exists(p)
  return
end

pr = stdlib.absolute(p);

try
  for part = py.psutil.disk_partitions(p)
    prt = part{1};
    if startsWith(pr, string(prt.mountpoint))
      t = string(prt.fstype);
      return
    end
  end
catch e
  warning(e.identifier, "filesystem_type(%s) failed: %s", p, e.message);
end

end
