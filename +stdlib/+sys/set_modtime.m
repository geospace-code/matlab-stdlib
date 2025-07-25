function ok = set_modtime(p, t)

ok = false;

if ~isfile(p), return, end

if ispc()
  cmd = sprintf('pwsh -Command "(Get-Item ''%s'').LastWriteTime = ''%s''"', p, string(t, "yyyy-MM-dd HH:mm:ss"));
elseif ismac()
  cmd = sprintf("touch -mt %s %s", string(t, "yyyyMMddHHmm"), p);
else
  % https://man7.org/linux/man-pages/man1/touch.1.html
  cmd = sprintf("touch -t %s %s", string(t, "yyyyMMddHHmm"), p);
end

[s, m] = system(cmd);
ok = s == 0;

if ~ok
  warning("stdlib:set_modtime:ValueError", "%s   set modification time of %s: %s", cmd, p, m);
end

end
