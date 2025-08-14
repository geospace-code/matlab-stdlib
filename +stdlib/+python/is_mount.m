%% PYTHON.IS_MOUNT is path a mount point
%
% https://docs.python.org/3/library/os.path.html#os.path.ismount

function y = is_mount(filepath)

y = logical.empty;
if ~stdlib.exists(filepath), return, end

% some Python on CI needs this. Didn't replicate on local Windows PC.
if ispc() && strcmp(filepath, stdlib.root_name(filepath)) && ~endsWith(filepath, ["/", "\"])
  y = false;
  return
end

try %#ok<TRYNC>
  y = py.os.path.ismount(filepath);
end

end
