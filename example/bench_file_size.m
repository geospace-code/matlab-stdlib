%% benchmark for file_size()

f = mfilename("fullpath") + ".m";

fno = @() stdlib.file_size(f, false);
fjava = @() stdlib.file_size(f, true);

t_no = timeit(fno);
t_java = timeit(fjava);

disp("No Java: " + t_no + " s")
disp("Java: " + t_java + " s")

disp("Java is " + t_no/t_java + " times faster")
