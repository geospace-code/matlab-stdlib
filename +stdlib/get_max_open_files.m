%% GET_MAX_OPEN_FILES  Get process open-file soft limit
% These limits can be important if using
% <https://www.mathworks.com/help/parallel-computing/recommended-system-limits-for-macintosh-and-linux.html Parallel Computing>

function [omax, b] = get_max_open_files(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["python", "shell"]
end

for b = backend
  f = str2func("stdlib." + b + ".get_max_open_files");
  omax = f();

  if ~ismissing(omax)
	return
  end
end

end
