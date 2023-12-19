function ok = is_exe(file)

arguments
  file string {mustBeScalarOrEmpty}
end

if isempty(file)
  ok = logical.empty;
  return
end

ok = java.io.File(file).canExecute();

end
