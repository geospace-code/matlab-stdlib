f = mfilename("fullpath") + ".m";
%f = tempname;

fno = @() stdlib.parent(f, false);
fjava = @() stdlib.parent(f, true);

t_no = timeit(fno);
t_java = timeit(fjava);

disp("No Java: " + t_no + " s")
disp("Java: " + t_java + " s")

disp("Java is " + t_no/t_java + " times faster")
