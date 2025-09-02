function ok = set_permissions(file, readable, writable, executable)
arguments
  file (1,1) string
  readable (1,1) {mustBeInteger}
  writable (1,1) {mustBeInteger}
  executable (1,1) {mustBeInteger}
end

ok = false;

if ~stdlib.exists(file), return, end

try
  p = filePermissions(file);
catch
  ok = logical.empty;
  return
end

k = string.empty;
v = logical.empty;

if readable ~= 0
  k(end+1) = "Readable";
  v(end+1) = readable > 0;
end

if writable ~= 0
  k(end+1) = "Writable";
  v(end+1) = writable > 0;
end

if executable ~= 0
  if ispc()
    if executable > 0 && ~ismember("Readable", k)
      k(end+1) = "Readable";
      v(end+1) = true;
    end
  else
    k(end+1) = "UserExecute";
    v(end+1) = executable > 0;
  end
end

ok = true;

if ~isempty(k)
  setPermissions(p, k, v)
end

end
