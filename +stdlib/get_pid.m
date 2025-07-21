%% GET_PID process ID of Matlab session

function pid = get_pid()

try
  pid = matlabProcessID;
catch e
  switch e.identifier
    case "MATLAB:UndefinedFunction", pid = feature("getpid");
    case "Octave:undefined-function", pid = getpid();
    otherwise, rethrow(e)
  end

  pid = uint64(pid);
end

end

%!assert (get_pid() > 0, "expected positive PID")
