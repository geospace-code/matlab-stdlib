%% benchmark

f = mfilename("fullpath") + ".m";
addpath(fullfile(fileparts(f), ".."))

%f = "abc";

fno = @() stdlib.absolute(f, false);

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
