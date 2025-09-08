function u = get_uid()

u = [];

if isunix()
  try
    u = double(py.os.geteuid());
  catch e
    pythonException(e)
  end
end

end
