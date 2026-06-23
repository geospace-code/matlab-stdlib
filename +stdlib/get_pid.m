%% GET_PID process ID of Matlab session

function pid = get_pid()

if stdlib.matlabOlderThan('R2025a')
  pid = uint64(feature('getpid'));
else
  pid = matlabProcessID;
end

end
