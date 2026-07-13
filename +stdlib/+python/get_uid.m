function u = get_uid()

if isunix()
  u = double(py.os.geteuid());
else
  u = missing;
end

end
