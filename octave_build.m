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
fullfile(d, "proximate_to.cpp"), ...
fullfile(d, "relative_to.cpp"), ...
};


%% build C+ Octave
for s = srcs
  src = s{1};
  [~, n] = fileparts(src);

  if ~overwrite && isfile(fullfile(t, [n, ".oct"]))
    continue
  end

  disp(["mkoctfile: ", src, " => ", n, ".oct"])
  mkoctfile(src, ["-I", inc], "--output", fullfile(t, n))
end
