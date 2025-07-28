%% PYTHON.HAS_PSUTIL is Python psutil module availble

function y = has_psutil()

y = pvt_psutil();
% this is to avoid Matlab < R2022a JIT but with Python in general

end
