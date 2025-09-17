%% NULL_FILE get null file path

function nul = null_file()

if ispc
  nul = 'NUL';
else
  nul = '/dev/null';
end

end

%!assert (~isempty(stdlib.null_file()))