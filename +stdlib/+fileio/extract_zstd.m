function extract_zstd(archive, out_dir)
% extract a zstd file "archive" to "out_dir"
% out_dir need not exist yet, but its parent must
% we do this in two steps to be reliable with old tar versions
% https://www.scivision.dev/tar-extract-zstd

arguments
  archive (1,1) string
  out_dir (1,1) string
end

import stdlib.fileio.expanduser
import stdlib.fileio.which

archive = expanduser(archive);

assert(isfile(archive), "%s is not a file", archive)

exe = which("zstd");
assert(~isempty(exe), "need to have Zstd installed: https://github.com/facebook/zstd")

tar_arc = tempname;

ret = system(exe + " -d " + archive + " -o " + tar_arc);
assert(ret == 0, "problem extracting %s", archive)

untar(tar_arc, out_dir)
delete(tar_arc)

end
