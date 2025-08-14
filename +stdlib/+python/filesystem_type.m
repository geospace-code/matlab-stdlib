function t = filesystem_type(p)

t = '';

% important for heuristic matching
if ~stdlib.exists(p)
  return
end

pr = stdlib.absolute(p);

try %#ok<TRYNC>
  for part = py.psutil.disk_partitions(p)
    prt = part{1};
    if startsWith(pr, char(prt.mountpoint))
      t = char(prt.fstype);
      return
    end
  end
end

end
