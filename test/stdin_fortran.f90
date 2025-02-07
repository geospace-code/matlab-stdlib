program stdin_pipe

use, intrinsic :: iso_fortran_env

implicit none

integer :: a, b, i

! Python and Matlab have the same issue with stdin truncation in Fortran across compilers.
! >>> subprocess.run("stdin_fortran.exe", input="1 2", capture_output=True, text=True)
! CompletedProcess(args='stdin_fortran.exe', returncode=0, stdout='     0.000\n', stderr='')
! >>> subprocess.run("stdin_fortran.exe", input="1 2\n", capture_output=True, text=True)
! CompletedProcess(args='stdin_fortran.exe', returncode=0, stdout='     3.000\n', stderr='')

read(input_unit, *, iostat=i) a, b
if (i == iostat_end) error stop "stdin was truncated -- add a newline at the end of the stdin input"
if (i /= 0) error stop "stdin read error"


write(output_unit, '(i0)') a + b

end program
