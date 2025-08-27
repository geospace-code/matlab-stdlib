%% benchmark for file_size()

f = mfilename("fullpath") + ".m";

fno = @() stdlib.file_size(f);

t_no = timeit(fno);

disp(t_no + " s")
