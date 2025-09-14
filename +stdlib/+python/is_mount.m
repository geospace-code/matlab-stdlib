%% PYTHON.IS_MOUNT is path a mount point
%
% https://docs.python.org/3/library/os.path.html#os.path.ismount

function y = is_mount(filepath)


try
  y = false;

  p = py.pathlib.Path(filepath);
  if ~p.exists()
    return
  end

  % some Python on CI needs this. Didn't replicate on local Windows PC.
  if ispc() && strcmp(filepath, string(p.drive)) && ~endsWith(filepath, ["/", filesep])
    return
  end

  y = py.os.path.ismount(p);
catch e
  pythonException(e)
  y = logical.empty;
end

end
