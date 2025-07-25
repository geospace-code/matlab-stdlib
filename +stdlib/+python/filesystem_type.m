function t = filesystem_type(p)

t = string.empty;

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
  warning(e.identifier, "%s", e.message)
end

end
