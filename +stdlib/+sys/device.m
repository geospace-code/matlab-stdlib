%% SYS.DEVICE get drive index
%
%%% Inputs
% * p: path
%%% Outputs
% * i: drive inde
% * cmd: command line command used


function [i, cmd] = device(p)

i = uint64([]);
if ~stdlib.exists(p), return, end

if ispc()
  c0 = 'pwsh -c "(Get-CimInstance -ClassName Win32_Volume -Filter \"DriveLetter = ''';
  c1 = stdlib.root_name(stdlib.absolute(p));
  c2 = '''\").SerialNumber"';
  % needs to be strcat as it could be char, or cast implicitly to string
  cmd = strcat(c0, c1, c2);
elseif ismac()
  cmd = sprintf('stat -f %%d "%s"', p);
else
  cmd = sprintf('stat -c %%d "%s"', p);
end

if stdlib.exists(p)
  [s, m] = system(cmd);
  if s == 0
    i = str2double(m);
  end
end

i = uint64(i);

end
