function h = test_homedir()

addpath(fullfile(fileparts(mfilename("fullpath")), "../.."))

h = stdlib.homedir();

end