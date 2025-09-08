function i = get_process_priority()


i = [];

if ~ispc()
  try
    pid = py.os.getpid();
    i = double(py.os.getpriority(py.os.PRIO_PROCESS, pid));
  catch e
    pythonException(e)
  end
end

end
