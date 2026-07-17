function y = is_removable(file)

y = false;

p = py.os.path.abspath(file);

% https://psutil.readthedocs.io/en/stable/index.html?highlight=disk_partitions#psutil.disk_partitions

for part = py.psutil.disk_partitions()
  prt = part{1};
  if p.startswith(prt.mountpoint)
    y = contains(string(prt.opts), ["cdrom", "removable"]);
    return
  end
end

end
