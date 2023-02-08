function extract_zstd(archive, out_dir)

arguments
  archive (1,1) string {mustBeFile}
  out_dir (1,1) string
end

archive = stdlib.fileio.absolute_path(archive);
out_dir = stdlib.fileio.absolute_path(out_dir);

assert(isfolder(out_dir), "%s is not a folder", out_dir)

exe = stdlib.fileio.which("cmake");
if isempty(exe)
  extract_zstd_bin(archive, outdir)
end

[ret, msg] = stdlib.sys.subprocess_run([exe, "-E", "tar", "xf", archive], "cwd", out_dir);
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
