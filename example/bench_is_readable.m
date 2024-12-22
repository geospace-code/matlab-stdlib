%% benchmark

f = mfilename("fullpath") + ".m";
addpath(fullfile(fileparts(f), ".."))

%f = tempname;

fno = @() stdlib.is_readable(f, false);
fjava = @() stdlib.is_readable(f, true);

t_no = timeit(fno);
t_java = timeit(fjava);

disp("No Java: " + t_no + " s")
disp("Java: " + t_java + " s")

disp("Java is " + t_no/t_java + " times faster")
