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

try
  ispar = ~isempty(getCurrentWorker());
catch e
  if e.identifier ~= "MATLAB:UndefinedFunction"
     rethrow(e)
  end
  ispar = false;
end

end
