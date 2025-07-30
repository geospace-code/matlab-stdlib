function ok = set_permissions(file, readable, writable, executable)

ok = false;

if ~stdlib.exists(file), return, end

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

if isempty(mode)
  ok = true;
  return
end

[s, msg, id] = fileattrib(file, mode);
ok = s == 1;
if ~ok
  warning(id, "Failed to set permissions %s for %s: %s", mode, file, msg)
end

end
