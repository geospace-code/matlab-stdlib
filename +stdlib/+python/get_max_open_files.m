%% python.get_max_open_files  Get process open-file soft limit via Python
function m = get_max_open_files()

% RLIMIT_NOFILE soft limit is the active per-process descriptor cap.
if ~ispc()
  lim = py.resource.getrlimit(py.resource.RLIMIT_NOFILE);
  m = uint64(lim(1));
else
  m = missing;
end

end
