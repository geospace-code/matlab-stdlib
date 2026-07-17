function t = filesystem_type(file)

t = missing;

% important for heuristic matching
p = py.os.path.abspath(file);

% https://psutil.readthedocs.io/en/stable/index.html?highlight=disk_partitions#psutil.disk_partitions

for part = py.psutil.disk_partitions()
  prt = part{1};
  if p.startswith(prt.mountpoint)
    t = char(prt.fstype);
    return
  end
end

end
