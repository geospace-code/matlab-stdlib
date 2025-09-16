function ok = set_permissions(file, readable, writable, executable)

mustBeInteger(readable)
mustBeInteger(writable)
mustBeInteger(executable)

p = filePermissions(file);

assert(isscalar(p), "set_permissions: one file only")

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
