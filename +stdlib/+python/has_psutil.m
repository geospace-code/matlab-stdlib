%% PYTHON.HAS_PSUTIL is Python psutil module availble

function y = has_psutil(force_old)
arguments
  force_old (1,1) logical = false
end

y = false;

% For MATLAB versions older than R2022a, skip Python version check unless force_old is true
if isMATLABReleaseOlderThan('R2022a') && ~force_old
  return
end

y = pvt_psutil();
% this is to avoid Matlab < R2022a JIT but with Python in general

end
