function gfortran_pipes_restore(oenv)
arguments
  oenv (1,1) struct
end

setenv('GFORTRAN_STDOUT_UNIT', oenv.stdout)
setenv('GFORTRAN_STDERR_UNIT', oenv.stderr)
setenv('GFORTRAN_STDIN_UNIT', oenv.stdin)

end
