%% GET_PID process ID of Matlab session

function pid = get_pid()

if stdlib.isoctave()
  pid = getpid();
else
  pid = feature("getpid");
end

end

%!assert(get_pid() > 0, "expected positive PID")
