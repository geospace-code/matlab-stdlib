%% GET_PID process ID of Matlab session

function pid = get_pid()

if stdlib.isoctave()
  pid = getpid();
elseif stdlib.matlabOlderThan('R2025a')
  pid = feature('getpid');
else
  pid = matlabProcessID;
end

pid = uint64(pid);

end

%!assert(stdlib.get_pid() > 0)