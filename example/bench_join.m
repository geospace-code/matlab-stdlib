a1 = "a/";
b1 = "b/c";

fno = @() stdlib.join(a1, b1);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
