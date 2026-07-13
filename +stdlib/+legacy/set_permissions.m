function ok = set_permissions(file, readable, writable, executable)
%% LEGACY.SET_PERMISSIONS set file permissions
%
% it is strongly recommended to use filePermissions instead, as setting permissions via fileattrib
% often fails

mode = '';
% mode is space-delimited
if ~ispc() && ~isempty(readable)
  if readable
    mode = [mode ' +r'];
  else
    mode = [mode ' -r'];
  end
end

if ~isempty(writable)
  if writable
    mode = [mode ' +w'];
  else
    mode = [mode ' -w'];
  end
end

if ~isempty(executable)
  if executable
    mode = [mode ' +x'];
  else
    mode = [mode ' -x'];
  end
end

if isempty(mode)
  ok = true;
  return
end

[ok, msg, id] = fileattrib(file, mode);
if ~ok
  error(id, 'Failed to set permissions %s for %s: %s', mode, file, msg)
end

end
