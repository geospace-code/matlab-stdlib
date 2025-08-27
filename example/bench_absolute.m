%% benchmark

f = mfilename("fullpath") + ".m";
addpath(fullfile(fileparts(f), ".."))

%f = "abc";

fno = @() stdlib.absolute(f);

t_no = timeit(fno);

disp(t_no + " s")
