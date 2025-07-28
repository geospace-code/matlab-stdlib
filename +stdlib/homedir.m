%% HOMEDIR get user home directory

function h = homedir()

if ispc()
  h = getenv("USERPROFILE");
else
  h = getenv("HOME");
end

end

%!assert(!isempty(homedir()))
