%% HOMEDIR get user home directory

function h = homedir()

if ispc
  h = getenv("USERPROFILE");
else
  h = getenv("HOME");
end

h = stdlib.posix(h);

end

%!assert(!isempty(homedir()))
