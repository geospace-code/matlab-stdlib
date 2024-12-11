%% IS_PARALLEL_WORKER  being executed by Parallel Computing Toolbox?
% detects if being executed by Parallel Computing Toolbox
% e.g. in a parfor loop
%
% Reference: https://www.mathworks.com/help/parallel-computing/getcurrenttask.html
%
% test by:
% >> is_parallel_worker
%
% ans = logical 0
%
% >> parfor i = 1:1, is_parallel_worker, end
% Starting parallel pool (parpool) using the 'local' profile ...
%
% ans = logical 1

function ispar = is_parallel_worker()

ispar = false;

addons = matlab.addons.installedAddons();
if any(contains(addons.Name, 'Parallel Computing Toolbox'))
  ispar = ~isempty(getCurrentWorker());
end

end
