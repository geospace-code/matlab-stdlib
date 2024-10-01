function r = is_rosetta()
% IS_ROSETTA Returns true if running on Apple Silicon using Rosetta (Matlab Intel binary)

r = false;

if ~ismac
  return
end

% uname -m reports "x86_64" from within Matlab on Apple Silicon if using Rosetta

[ret, raw] = system("sysctl -n sysctl.proc_translated");
r = ret == 0 && startsWith(raw, "1");

end
