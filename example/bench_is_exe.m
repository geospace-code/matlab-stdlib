%% benchmark

f = mfilename("fullpath") + ".m";
addpath(fullfile(fileparts(f), ".."))

%f = tempname;

fno = @() stdlib.is_exe(f);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
