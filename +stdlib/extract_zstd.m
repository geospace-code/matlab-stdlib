function extract_zstd(archive, out_dir)
%% extract_zstd(archive, out_dir)
% extract a zstd file "archive" to "out_dir"
% out_dir need not exist yet, but its parent must
% We do this with CMake to avoid problems with old system tar.
% For our user audience, CMake is at least as likely to be installed as Zstd.
arguments
  archive (1,1) string {mustBeFile}
  out_dir (1,1) string {mustBeFolder}
end

archive = stdlib.absolute(archive);
out_dir = stdlib.absolute(out_dir);

exe = stdlib.which("cmake");
if isempty(exe)
  extract_zstd_bin(archive, out_dir)
end

[ret, msg] = stdlib.subprocess_run([exe, "-E", "tar", "xf", archive], cwd=out_dir);
assert(ret == 0, "problem extracting %s   %s", archive, msg)

end


function extract_zstd_bin(archive, out_dir)
% Extract .zst in two steps .zst => .tar =>
% to avoid problems with old system tar.
arguments
  archive (1,1) string
  out_dir (1,1) string
end

exe = stdlib.which("zstd");
assert(~isempty(exe), "need to have Zstd installed: https://github.com/facebook/zstd")

tar_arc = tempname;

ret = system(exe + " -d " + archive + " -o " + tar_arc);
assert(ret == 0, "problem extracting %s", archive)

untar(tar_arc, out_dir)
delete(tar_arc)
end
