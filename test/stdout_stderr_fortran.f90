program main

use, intrinsic :: iso_fortran_env

implicit none

print '(a)', compiler_version()

write(output_unit, '(a)') "stdout"
write(error_unit, '(a)') "stderr"

end program
