function ok = set_permissions(file, readable, writable, executable)

p = filePermissions(file);

assert(isscalar(p), "set_permissions: one file only")

k = string.empty;
v = logical([]);

if ~isempty(readable)
  k(end+1) = "Readable";
  v(end+1) = readable;
end

if ~isempty(writable)
  k(end+1) = "Writable";
  v(end+1) = writable;
end

if ~isempty(executable)
  if ispc()
    if executable && ~ismember("Readable", k)
      k(end+1) = "Readable";
      v(end+1) = true;
    end
  else
    k(end+1) = "UserExecute";
    v(end+1) = executable;
  end
end

ok = true;

if ~isempty(k)
  setPermissions(p, k, v)
end

end
