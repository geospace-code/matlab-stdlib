%% GET_PID process ID of Matlab session

function pid = get_pid()

try
  pid = matlabProcessID;
catch e
  switch e.identifier
    case "MATLAB:UndefinedFunction", pid = uint64(feature("getpid"));
    case "Octave:undefined-function", pid = uint64(getpid());
    otherwise, rethrow(e)
  end
end

end

%!assert (get_pid() > 0, "expected positive PID")
