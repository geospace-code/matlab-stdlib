function oenv = gfortran_pipes()
% https://www.mathworks.com/matlabcentral/answers/91919-why-does-the-output-of-my-fortran-script-not-show-up-in-the-matlab-command-window-when-i-execute-it#answer_101270
% Matlab grabs the stdout, stderr, stdin handles of a Gfortran program, even when it's using Java.
% We must disable this behavior for the duration of the running process.

oenv.stdout = getenv('GFORTRAN_STDOUT_UNIT');
setenv('GFORTRAN_STDOUT_UNIT', '6')

oenv.stderr = getenv('GFORTRAN_STDERR_UNIT');
setenv('GFORTRAN_STDERR_UNIT', '0')

oenv.stdin = getenv('GFORTRAN_STDIN_UNIT');
setenv('GFORTRAN_STDIN_UNIT', '5')

end
