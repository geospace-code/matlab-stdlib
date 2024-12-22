%% benchmark

f = mfilename("fullpath") + ".m";
addpath(fullfile(fileparts(f), ".."))

%f = "abc";

fno = @() stdlib.absolute(f, false);
fjava = @() stdlib.absolute(f, true);

t_no = timeit(fno);
t_java = timeit(fjava);

disp("No Java: " + t_no + " s")
disp("Java: " + t_java + " s")

disp("Java is " + t_no/t_java + " times faster")
