function t = filesystem_type(file)
arguments
  file (1,1) string
end

t = '';

% important for heuristic matching
if ~stdlib.exists(file)
  return
end

pr = stdlib.absolute(file);

try %#ok<TRYNC>
  for part = py.psutil.disk_partitions(file)
    prt = part{1};
    if startsWith(pr, char(prt.mountpoint))
      t = char(prt.fstype);
      return
    end
  end
end

end
