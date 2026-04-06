%% sys.get_max_open_files  Get process open-file soft limit via shell
function omax = get_max_open_files()

omax = [];

if ispc()
  omax = uint64(omax);
  return
end

[s, m] = system('ulimit -n');
if s == 0
  omax = str2double(strtrim(m));

  if ~isfinite(omax) || omax <= 0
    omax = [];
  end
end

omax = uint64(omax);

end
