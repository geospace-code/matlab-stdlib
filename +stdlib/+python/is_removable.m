function y = is_removable(file)

y = false;

% important for heuristic matching
try
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
catch e
  pythonException(e)
  y = logical.empty;
end

end
