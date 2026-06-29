function [v, msg] = version()

persistent stdlib_py_version pyv_cached

msg = missing;

if isempty(pyv_cached)
  pyv_cached = false;
elseif pyv_cached
  v = stdlib_py_version;
  return
end

% Matlab < R2022a has a bug in the JIT compiler that breaks try-catch
% for any py.* command.
% We use a separate private function to workaround that.

v = [];

% glitchy Python load can error on shell.version_info
% if pyenv() hasn't ever been configured, may get uncatchable error
% bad lexical cast: source type value could not be interpreted as target
old = getenv('KMP_DUPLICATE_LIB_OK');
setenv('KMP_DUPLICATE_LIB_OK', 'TRUE')
try
  v = pvt_python_version();
catch e
  msg = e.message;
end
setenv('KMP_DUPLICATE_LIB_OK', old)

% cache the result - even if empty -- because the check takes up to 1000 ms say on HPC
stdlib_py_version = v;
pyv_cached = true;

end
