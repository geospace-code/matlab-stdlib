f = mfilename("fullpath") + ".m";
%f = tempname;

fno = @() stdlib.exists(f);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
