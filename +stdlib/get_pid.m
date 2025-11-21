function pid = get_pid()
% GET_PID process ID of Matlab session

if stdlib.matlabOlderThan('R2025a')
  pid = feature('getpid'); %#ok<FEATGPID>
else
  pid = matlabProcessID;
end

pid = uint64(pid);

end
