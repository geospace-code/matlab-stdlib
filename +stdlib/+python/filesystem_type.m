function t = filesystem_type(file)

t = '';

try
% important for heuristic matching
  p = py.str(file);
  if ~py.os.path.exists(p)
    return
  end

  p = py.os.path.abspath(p);

% https://psutil.readthedocs.io/en/stable/index.html?highlight=disk_partitions#psutil.disk_partitions

  for part = py.psutil.disk_partitions()
    prt = part{1};
    if p.startswith(prt.mountpoint)
      t = char(prt.fstype);
      return
    end
  end
catch e
  pythonException(e)
end

end
