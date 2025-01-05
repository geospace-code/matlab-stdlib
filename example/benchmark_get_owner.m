a1 = ".";

fjava = @() stdlib.get_owner(a1);

t_java = timeit(fjava);

disp("Java: " + t_java + " s")
