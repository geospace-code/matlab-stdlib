function ok = is_exe(file)
%% is_exe(file)
% is a file executable, as per its filesystem attributes
% does not actually try to run the file.
%%% Inputs
% * file: filename
%%% Outputs
% * ok: boolean logical

arguments
  file (1,1) string {mustBeNonzeroLengthText}
end

if ~isfile(file)
  ok = false;
  return
end

[ok1, stat] = fileattrib(file);
ok = ok1 == 1 && (stat.UserExecute == 1 || stat.GroupExecute == 1);

end
