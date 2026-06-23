%% python.get_max_open_files  Get process open-file soft limit via Python
function omax = get_max_open_files()

omax = missing;

if ispc()
  return
end

try
	% RLIMIT_NOFILE soft limit is the active per-process descriptor cap.
	lim = py.resource.getrlimit(py.resource.RLIMIT_NOFILE);
	omax = uint64(lim(1));
catch e
	pythonException(e)
	omax = missing;
end

end
