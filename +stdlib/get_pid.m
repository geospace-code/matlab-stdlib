%% GET_PID process ID of Matlab session

function pid = get_pid()

if ~isMATLABReleaseOlderThan('R2025a')
  pid = matlabProcessID;
else
  pid = feature("getpid");
end

pid = uint64(pid);

end
