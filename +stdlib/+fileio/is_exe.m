function ok = is_exe(file)

arguments
  file string {mustBeScalarOrEmpty}
end

if isempty(file)
  ok = logical.empty;
  return
end

if ~isfile(file)
  ok = false;
  return
end

[ok1, stat] = fileattrib(file);
ok = ok1 == 1 && (stat.UserExecute == 1 || stat.GroupExecute == 1);

end
