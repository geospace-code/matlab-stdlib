function [r, cmd] = samepath(file1, file2)

cmd = sprintf('''%s'' -e ''(@ARGV==2) or exit 1; @s1 = stat shift or exit 1; @s2 = stat shift or exit 1; exit(($s1[0]==$s2[0] && $s1[1]==$s2[1]) ? 0 : 1)'' "%s" "%s"', ...
        stdlib.perl_exe(), file1, file2);

s = system(cmd);

r = s == 0;

end
