% Build C++-based .oct file for GNU Octave

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
};


%% build C+ Octave
for s = srcs
  src = s{1};
  [~, n] = fileparts(src);

  disp(["mkoctfile: ", src, " => ", n, ".oct"])
  mkoctfile(src, ["-I", inc], "--output", fullfile(t, n))
end
