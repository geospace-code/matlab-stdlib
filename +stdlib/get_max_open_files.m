%% GET_MAX_OPEN_FILES  Get process open-file soft limit
% These limits can be important if using
% <https://www.mathworks.com/help/parallel-computing/recommended-system-limits-for-macintosh-and-linux.html Parallel Computing>

function [m, b] = get_max_open_files(backend)
arguments
  backend (1,:) string {mustBeNonempty} = ["python", "shell"]
end

m = missing;

for b = filterBackend(backend)
  f = str2func("stdlib." + b + ".get_max_open_files");
  m = f();

  if ~ismissing(m)
	return
  end
end

end
