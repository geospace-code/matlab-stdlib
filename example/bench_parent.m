f = mfilename("fullpath") + ".m";

fno = @() stdlib.parent(f);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
