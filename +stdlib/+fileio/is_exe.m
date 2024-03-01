function ok = is_exe(file)
%% is_exe is file executable
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#canExecute()

arguments
  file string {mustBeScalarOrEmpty}
end

if isempty(file)
  ok = logical.empty;
  return
end

ok = java.io.File(file).canExecute();

end
