%% GET_PID process ID of Matlab session

function pid = get_pid()

try
  pid = matlabProcessID;
catch e
  if strcmp(e.identifier, "MATLAB:UndefinedFunction")
    pid = uint64(feature("getpid"));
  elseif strcmp(e.identifier, "Octave:undefined-function")
    pid = uint64(getpid());
  else
    rethrow(e)
  end
end

end

%!assert (get_pid() > 0, "expected positive PID")
