function n = get_hostname()

cmd = 'hostname';
[s, n] = system(cmd);

if s == 0
  n = char(strtrim(n));
else
  n = '';
end

end
