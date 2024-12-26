a1 = "c:/a/";

fno = @() stdlib.is_absolute(a1, false);
fjava = @() stdlib.is_absolute(a1, true);

t_no = timeit(fno);
t_java = timeit(fjava);

disp("No Java: " + t_no + " s")
disp("Java: " + t_java + " s")

disp("Java is " + t_no/t_java + " times faster")
