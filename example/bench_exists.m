f = mfilename("fullpath") + ".m";
%f = tempname;

fno = @() stdlib.exists(f);

t_no = timeit(fno);

disp(t_no + " s")
