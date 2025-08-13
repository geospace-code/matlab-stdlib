function ok = set_modtime(file, dt)

ok = false;

if ~isfile(file), return, end

if ispc()
  cmd = sprintf('pwsh -c "(Get-Item ''%s'').LastWriteTime = ''%s''"', file, string(dt, "yyyy-MM-dd HH:mm:ss"));
elseif ismac()
  cmd = sprintf("touch -mt %s %s", string(dt, "yyyyMMddHHmm"), file);
else
  % https://man7.org/linux/man-pages/man1/touch.1.html
  cmd = sprintf("touch -t %s %s", string(dt, "yyyyMMddHHmm"), file);
end

[s, m] = system(cmd);
ok = s == 0;

if ~ok
  warning("stdlib:set_modtime:ValueError", "%s   set modification time of %s: %s", cmd, file, m);
end

end
