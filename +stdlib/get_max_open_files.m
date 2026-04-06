%% GET_MAX_OPEN_FILES  Get process open-file soft limit
% These limits can be important if using 
% <https://www.mathworks.com/help/parallel-computing/recommended-system-limits-for-macintosh-and-linux.html Parallel Computing>

function [omax, b] = get_max_open_files(backend)

if nargin < 1
  backend = {'python', 'sys'};
else
  backend = cellstr(backend);
end

omax = uint64([]);

for j = 1:numel(backend)
	b = backend{j};

	switch b
		case 'python'
			if stdlib.has_python()
				omax = stdlib.python.get_max_open_files();
			end
		case 'sys'
			omax = stdlib.sys.get_max_open_files();
		otherwise
			error('stdlib:get_max_open_files:ValueError', 'Unknown backend: %s', b)
	end

	if ~isempty(omax)
		return
	end
end

end

%!test
%! n = stdlib.get_max_open_files();
%! assert(isscalar(n));
%! assert(n > 0);
