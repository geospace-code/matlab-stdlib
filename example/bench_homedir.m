%% benchmark for exists()

fno = @() stdlib.homedir();

t_no = timeit(fno);

disp("No Java: " + t_no + " s")
