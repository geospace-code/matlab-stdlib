function ok = set_permissions(file, readable, writable, executable)
%% LEGACY.SET_PERMISSIONS set file permissions
%
% it is strongly recommended to use filePermissions instead, as setting permissions via fileattrib
% often fails

mode = '';
% mode is space-delimited
if ~ispc()
  if readable == 1
    mode = [mode ' +r'];
  elseif readable == -1
    mode = [mode ' -r'];
  end
end

if writable == 1
  mode = [mode ' +w'];
elseif writable == -1
  mode = [mode ' -w'];
end

if executable == 1
  mode = [mode ' +x'];
elseif executable == -1
  mode = [mode ' -x'];
end

if isempty(mode) && stdlib.exists(file)
  ok = true;
  return
end

[s, msg, id] = fileattrib(char(file), mode);
ok = s == 1;
if ~ok
  warning(id, 'Failed to set permissions %s for %s: %s', mode, file, msg)
end

end
