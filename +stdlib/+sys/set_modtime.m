function [ok, cmd] = set_modtime(file, dt)

if ispc()
  fmt = 'yyyy-MM-dd HH:mm:ss';
else
  fmt = 'yyyyMMddHHmm';
end


if ispc()
  cmd = sprintf('pwsh -c "(Get-Item ''%s'').LastWriteTime = ''%s''"', file, string(datetime(dt), fmt));
elseif ismac()
  cmd = sprintf('touch -mt %s "%s"', string(datetime(dt), fmt), file);
else
  cmd = sprintf('touch -t %s "%s"', string(datetime(dt), fmt), file);
end
% https://man7.org/linux/man-pages/man1/touch.1.html

[s, ~] = system(cmd);
ok = s == 0;

end
