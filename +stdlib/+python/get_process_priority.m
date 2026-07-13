function i = get_process_priority()

pid = py.os.getpid();
i = double(py.os.getpriority(py.os.PRIO_PROCESS, pid));

end
