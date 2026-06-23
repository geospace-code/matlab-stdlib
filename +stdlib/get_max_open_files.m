%% GET_MAX_OPEN_FILES  Get process open-file soft limit
% These limits can be important if using
% <https://www.mathworks.com/help/parallel-computing/recommended-system-limits-for-macintosh-and-linux.html Parallel Computing>

function [omax, b] = get_max_open_files(backend)
arguments
  backend (1,:) string = ["python", "shell"]
end

omax = missing;

for b = backend
	switch b
		case 'python'
			if stdlib.has_python()
				omax = stdlib.python.get_max_open_files();
			end
		case 'shell'
			omax = stdlib.shell.get_max_open_files();
		otherwise
			error('stdlib:get_max_open_files:ValueError', 'Unknown backend: %s', b)
	end

	if ~ismissing(omax)
		return
	end
end

end
