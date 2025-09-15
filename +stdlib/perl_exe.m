%% PERL_EXE get the location of the Perl executable used by Matlab
% this is cached for speed

function exe = perl_exe()

persistent perle

if ~isempty(perle)
  exe = perle;
  return
end

ps = [fileparts(mfilename("fullpath")), '/private/executable.pl'];

[r, s] = perl(ps);

if s == 0 && isfile(r)
  exe = r;
  perle = r;
else
  exe = string.empty;
end

end
