%% shell.DEVICE get drive index
%
%%% Inputs
% * p: path
%%% Outputs
% * i: drive inde
% * cmd: command line command used


function [i, cmd] = device(p)

if ispc()
  rn = stdlib.root_name(stdlib.absolute(p));

  % Get-CimInstance works, but is 100x slower
  % c0 = 'pwsh -c "(Get-CimInstance -ClassName Win32_Volume -Filter \"DriveLetter = ''';
  % c2 = '''\").SerialNumber"';
  % cmd = stdlib.append(c0, rn, c2);

  cmd = sprintf('vol "%s"', rn);
elseif ismac()
  cmd = sprintf('stat -f %%d "%s"', p);
else
  cmd = sprintf('stat -c %%d "%s"', p);
end

[s, m] = system(cmd);
assert(s==0, "stdlib:shell:device", "Failed to get device index for %s using %s: %s ", p, cmd, m);

if ispc()
  r = regexp(m, '[A-F0-9]{4}-[A-F0-9]{4}', 'match', 'once');
  assert(strlength(r) == 9, "stdlib:shell:device", "Failed to get device index for %s using %s: %s ", p, cmd, m);
  r = [r(1:4) r(6:9)];
  i = uint64(hex2dec(r));
else
  i = uint64(str2double(m));
end

end
