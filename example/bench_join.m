a1 = "a/";
b1 = "b/c";

fno = @() stdlib.join(a1, b1, false);
fjava = @() stdlib.join(a1, b1, true);

t_no = timeit(fno);
t_java = timeit(fjava);

disp("No Java: " + t_no + " s")
disp("Java: " + t_java + " s")

disp("Java is " + t_no/t_java + " times faster")
