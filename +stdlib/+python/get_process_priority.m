function i = get_process_priority()

if ~ispc() && stdlib.has_python()
  pid = py.os.getpid();
  i = double(py.os.getpriority(py.os.PRIO_PROCESS, pid));
else
  i = missing;
end

end
