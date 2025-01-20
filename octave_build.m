% Build C++-based .oct file for GNU Octave
function octave_build(overwrite)
if nargin < 1, overwrite = false; end

assert(stdlib.isoctave(), "for GNU Octave only")

r = fileparts(mfilename("fullpath"));
inc = fullfile(r, "src");
d = fullfile(inc, "octave");
t = fullfile(r, "+stdlib");

%% specific source
srcs = {
fullfile(d, "drop_slash.cpp"), ...
fullfile(d, "is_wsl.cpp"), ...
fullfile(d, "is_rosetta.cpp"), ...
fullfile(d, "is_admin.cpp"), ...
fullfile(d, "parent.cpp"), ...
fullfile(d, "proximate_to.cpp"), ...
fullfile(d, "relative_to.cpp"), ...
};

% need this for loop below
unlink_bin = fullfile(t, "unlink.oct");
if ~isfile(unlink_bin)
  mkoctfile(fullfile(d, "unlink.cpp"), ["-I", inc], "--output", unlink_bin)
end

%% build C+ Octave
for s = srcs
  src = s{1};
  [~, n] = fileparts(src);
  bin = fullfile(t, [n, ".oct"]);

  if ~overwrite && stdlib.get_modtime(src) < stdlib.get_modtime(bin)
    continue
  end

  disp(["mkoctfile: ", src, " => ", bin])
  if isfile(bin)
    assert(stdlib.unlink(bin))
  end
  mkoctfile(src, ["-I", inc], "--output", bin)
end
