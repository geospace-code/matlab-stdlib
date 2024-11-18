function fc = find_fortran_compiler(FC)
%% find_fortran_compiler(FC)
% Find Fortran compiler
% for Fortran 2008+ compilers
%
% fc = find_fortran_compiler()   finds the first Fortran compiler available
% and working on your system.
%
% fc = find_fortran_compiler(FC) searches first for the compiler specified
% in string FC.

arguments
  FC (1,1) string = getenv('FC')
end

% stops upon finding first working Fortran compiler
FCs = ["gfortran", "ifx", "flang", "nvfortran", "nagfor", "ftn"];

if strlength(FC) > 0
  FCs = [FC, FCs];
end

fstem = tempname;
fn = fstem + ".f90";
rfn = fstem + ".exe";

prog = 'program; use iso_fortran_env; print *,compiler_version(); end program';
fid = fopen(fn, 'wt');
fprintf(fid, '%s\n', prog);
fclose(fid);

for f = FCs
  fc = stdlib.which(f);
  if isempty(fc)
    continue
  end

  [stat, ~] = system(fc + " " + fn + " -o" + rfn);  % gobble error messages
  if stat ~= 0
    continue
  end

  [stat, msg] = system(rfn);
  if stat == 0
    disp(msg)
    return
  end
end

if ~isempty(fc) && stat ~= 0
  fc = string.empty;
end

end
