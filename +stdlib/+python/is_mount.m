%% PYTHON.IS_MOUNT is path a mount point
%
% https://docs.python.org/3/library/os.path.html#os.path.ismount

function y = is_mount(filepath)

try
  y = py.os.path.ismount(filepath);
catch e
  warning(e.identifier, "Python is_mount failed: %s", e.message);
  y = false;
end

end
