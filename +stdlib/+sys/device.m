%% SYS.DEVICE get drive index
%
%%% Inputs
% * p: path
%%% Outputs
% * i: drive inde
% * cmd: command line command used


function [i, cmd] = device(p)

i = [];

if ispc()
  rn = stdlib.root_name(stdlib.absolute(p));

  % Get-CimInstance works, but is 100x slower
  % c0 = 'pwsh -c "(Get-CimInstance -ClassName Win32_Volume -Filter \"DriveLetter = ''';
  % c2 = '''\").SerialNumber"';
  % cmd = strcat(c0, rn, c2);

  cmd = sprintf('vol "%s"', rn);
elseif ismac()
  cmd = sprintf('stat -f %%d "%s"', p);
else
  cmd = sprintf('stat -c %%d "%s"', p);
end

if stdlib.exists(p)
  [s, m] = system(cmd);
  if s == 0
    if ispc()
      r = regexp(m, '[A-F0-9]{4}-[A-F0-9]{4}', 'match', 'once');
      if strlength(r) == 9
        r = [r(1:4) r(6:9)];
        i = hex2dec(r);
      end
    else
      i = str2double(m);
    end
  end
end

i = uint64(i);

end
