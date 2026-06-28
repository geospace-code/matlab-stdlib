function y = is_removable(file)

y = false;

if stdlib.has_python() && stdlib.python.has_psutil()
  p = py.str(file);
  if ~py.os.path.exists(p)
    return
  end

  p = py.os.path.abspath(p);

% https://psutil.readthedocs.io/en/stable/index.html?highlight=disk_partitions#psutil.disk_partitions

  for part = py.psutil.disk_partitions()
    prt = part{1};
    if p.startswith(prt.mountpoint)
      y = contains(string(prt.opts), ["cdrom", "removable"]);
      return
    end
  end
else
  y = missing;
end

end
