%% IS_DEV_DRIVE is path on a Windows Dev Drive developer volume

function [y, b] = is_dev_drive(fpath, backend)
arguments
  fpath (1,1) string
  backend (1,:) string = ["python", "sys"]
end

o = stdlib.Backend(mfilename(), backend);
y = o.func(fpath);
b = o.backend;

end
