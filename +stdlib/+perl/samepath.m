function [r, cmd] = samepath(file1, file2)

c = '(@ARGV==2) or exit 1; @s1 = stat shift or exit 1; @s2 = stat shift or exit 1; exit(($s1[0]==$s2[0] && $s1[1]==$s2[1]) ? 0 : 1)';
if ispc()
  k = sprintf('"%s"', c);
else
  k = sprintf('''%s''', c);
end

r = logical.empty;

exe = stdlib.perl_exe();
if stdlib.strempty(exe)
  return
end

cmd = sprintf('"%s" -e %s "%s" "%s"', exe, k, file1, file2);

s = system(cmd);

r = s == 0;

end
