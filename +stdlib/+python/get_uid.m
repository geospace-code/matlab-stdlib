function u = get_uid()

if isunix()
  u = double(py.os.geteuid());
else
  u = [];
end

end
