%% shell.get_max_open_files  Get process open-file soft limit via shell
function m = get_max_open_files()

m = missing;

if ~ispc()

[s, m] = system('ulimit -n');
if s == 0
  o = str2double(strtrim(m));

  if isfinite(o) && o > 0
    m = uint64(o);
  end
end

end

end
