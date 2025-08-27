%% benchmark for exists()

fno = @() stdlib.homedir();

t_no = timeit(fno);

disp(t_no + " s")
