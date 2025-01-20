a1 = "c:/a///.//../////b";

fno = @() stdlib.normalize(a1);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")