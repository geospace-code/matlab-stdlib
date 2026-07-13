%% GET_MAX_OPEN_FILES  Get process open-file soft limit
% These limits can be important if using
% <https://www.mathworks.com/help/parallel-computing/recommended-system-limits-for-macintosh-and-linux.html Parallel Computing>

function [i, b] = get_max_open_files(backend)
arguments
  backend (1,:) string = ["python", "shell"]
end

[i, b] = getUsingBackend(backend, mfilename);

end
