%% PERL_EXE get the location of the Perl executable used by Matlab
% this is cached for speed

function exe = perl_exe()

persistent perle

if ~isempty(perle)
  exe = perle;
  return
end

ps = [fileparts(mfilename("fullpath")), '/private/executable.pl'];

exe = '';

try
  [r, s] = perl(ps);
catch e
  if strcmp(e.identifier, 'MATLAB:perl:FileNotFound')
    return
  end
  rethrow(e)
end

if s == 0 && stdlib.is_file(r)
  exe = r;
  perle = r;
end

end

%!assert (isfile(stdlib.perl_exe()))
