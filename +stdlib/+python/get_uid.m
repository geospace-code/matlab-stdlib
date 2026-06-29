function u = get_uid()

if isunix() && stdlib.has_python()
  u = double(py.os.geteuid());
else
  u = missing;
end

end
