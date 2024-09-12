function nul = null_file()

if ispc
  nul = "NUL";
else
  nul = "/dev/null";
end

end