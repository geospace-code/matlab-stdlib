%% benchmark for file_size()

f = mfilename("fullpath") + ".m";

fno = @() stdlib.file_size(f, false);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
