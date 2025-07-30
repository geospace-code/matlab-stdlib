function ok = set_permissions(file, readable, writable, executable)

p = filePermissions(file);

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
    if executable > 0 && ~any(ismember(k, "Readable"))
      k(end+1) = "Readable";
      v(end+1) = true;
    end
  else
    k(end+1) = "Executable";
    v(end+1) = executable > 0;
  end
end

ok = true;

if ~isempty(k)
  setPermissions(p, k, v)
end

end
