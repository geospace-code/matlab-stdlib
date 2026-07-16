%% shell.get_max_open_files  Get process open-file soft limit via shell
function i = get_max_open_files()

[s, m] = system('ulimit -n');
assert(s == 0, 'stdlib:shell:get_max_open_files', 'Error executing get_max_open_files command: %s', m);
i = str2double(strtrim(m));

if isfinite(i) && i > 0
  i = uint64(i);
else
  i = missing;
end

end
