function nul = null_file()
%% NULL_FILE get null file path
if ispc
  nul = "NUL";
else
  nul = "/dev/null";
end

end
