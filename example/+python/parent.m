function par = parent(pth)
arguments
  pth (1,1) string
end

try
  op = py.pathlib.Path(pth);
  p = op.parent;
  par = string(py.str(p));  % 2x faster than string(op.parents(1))
  if ispc() && p == op.drive
    par = par + filesep;
  end
catch e
  par = "";
end

end
