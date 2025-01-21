f = mfilename("fullpath") + ".m";

fno = @() stdlib.stemed(f);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
