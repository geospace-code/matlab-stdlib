function i = get_process_priority()

if ispc()
  i = [];
else
  pid = py.os.getpid();
  i = double(py.os.getpriority(py.os.PRIO_PROCESS, pid));
end

end
