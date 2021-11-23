function extract_zstd(archive, out_dir)
% extract a zstd file "archive" to "out_dir"
% out_dir need not exist yet, but its parent must
% We do this with CMake to avoid problems with old system tar.
% For our user audience, CMake is at least as likely to be installed as Zstd.

arguments
  archive (1,1) string
  out_dir (1,1) string
end

import stdlib.fileio.absolute_path
import stdlib.fileio.which
import stdlib.sys.subprocess_run

archive = absolute_path(archive);
out_dir = absolute_path(out_dir);

assert(isfile(archive), "%s is not a file", archive)
assert(isfolder(out_dir), "%s is not a folder", out_dir)

exe = which("cmake");
if isempty(exe)
  extract_zstd_bin(archive, outdir)
end

[ret, msg] = subprocess_run([exe, "-E", "tar", "xf", archive], "cwd", out_dir);
assert(ret == 0, "problem extracting %s   %s", archive, msg)

end


function extract_zstd_bin(archive, out_dir)
% Extract .zst in two steps .zst => .tar =>
% to avoid problems with old system tar.
arguments
  archive (1,1) string
  out_dir (1,1) string
end

exe = which("zstd");
assert(~isempty(exe), "need to have Zstd installed: https://github.com/facebook/zstd")

tar_arc = tempname;

ret = system(exe + " -d " + archive + " -o " + tar_arc);
assert(ret == 0, "problem extracting %s", archive)

untar(tar_arc, out_dir)
delete(tar_arc)
end
