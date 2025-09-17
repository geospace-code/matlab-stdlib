function [ok, cmd] = set_modtime(file, dt)

tiso = string(datetime(dt), 'yyyy-MM-dd HH:mm:ss');

if ispc()
  cmd = sprintf('pwsh -c "(Get-Item ''%s'').LastWriteTime = ''%s''"', file, tiso);
elseif ismac()
  cmd = sprintf('touch -mt %s "%s"', string(dt, 'yyyyMMddHHmm'), file);
else
  cmd = sprintf('touch -t %s "%s"', string(dt, 'yyyyMMddHHmm'), file);
end
% https://man7.org/linux/man-pages/man1/touch.1.html

[s, ~] = system(cmd);
ok = s == 0;

end
