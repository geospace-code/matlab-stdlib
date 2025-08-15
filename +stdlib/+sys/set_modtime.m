function [ok, cmd] = set_modtime(file, dt)
arguments
  file (1,1) string
  dt (1,1) datetime
end

ok = false;

if ispc()
  cmd = sprintf('pwsh -c "(Get-Item ''%s'').LastWriteTime = ''%s''"', file, string(dt, "yyyy-MM-dd HH:mm:ss"));
elseif ismac()
  cmd = sprintf('touch -mt %s "%s"', string(dt, "yyyyMMddHHmm"), file);
else
  cmd = sprintf('touch -t %s "%s"', string(dt, "yyyyMMddHHmm"), file);
end
% https://man7.org/linux/man-pages/man1/touch.1.html

if isfile(file)
  [s, ~] = system(cmd);
  ok = s == 0;
end

end
