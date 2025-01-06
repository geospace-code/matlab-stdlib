a1 = "c:/a/";

fno = @() stdlib.is_absolute(a1);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
