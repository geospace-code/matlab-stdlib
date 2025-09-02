%% PERL_EXE get the location of the Perl executable used by Matlab
% this is cached for speed

function exe = perl_exe()

persistent perle

if ~isempty(perle)
  exe = perle;
  return
end

cwd = fileparts(mfilename("fullpath"));

[r, s] = perl(cwd + "/private/executable.pl");

if s == 0 && isfile(r)
  exe = r;
  perle = r;
else
  exe = string.empty;
end

end
