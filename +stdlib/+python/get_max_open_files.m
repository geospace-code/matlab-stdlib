%% python.get_max_open_files  Get process open-file soft limit via Python
function omax = get_max_open_files()

omax = [];

if ispc()
	omax = uint64(omax);
	return
end

try
	% RLIMIT_NOFILE soft limit is the active per-process descriptor cap.
	lim = py.resource.getrlimit(py.resource.RLIMIT_NOFILE);
	omax = lim(1);
catch e
	pythonException(e)
	omax = [];
end

omax = uint64(omax);

end
