%% python.get_max_open_files  Get process open-file soft limit via Python
function m = get_max_open_files()

if ispc()
  msvcrt = py.getattr(py.ctypes.windll, 'msvcrt');
  getmaxstdio = py.getattr(msvcrt, '_getmaxstdio');
  m = uint64(getmaxstdio());
else
% RLIMIT_NOFILE soft limit is the active per-process descriptor cap.
  lim = py.resource.getrlimit(py.resource.RLIMIT_NOFILE);
  m = uint64(lim(1));
end


end
