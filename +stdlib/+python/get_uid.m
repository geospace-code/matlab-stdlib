function u = get_uid()

u = missing;

if isunix()
  try
    u = double(py.os.geteuid());
  catch e
    pythonException(e)
  end
end

end
