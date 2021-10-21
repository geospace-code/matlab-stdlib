function ok = is_exe(file)
%% ok = is_exe(file)
% is a file executable?

arguments
  file (1,1) string
end

if ~isfile(file)
  ok = false;
  return
end

[ok1, stat] = fileattrib(file);
ok = ok1 == 1 && (stat.UserExecute == 1 || stat.GroupExecute == 1);

end
