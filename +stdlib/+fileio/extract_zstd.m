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

archive = expanduser(archive);

assert(isfile(archive), "%s is not a file", archive)

[ret, ~] = system("zstd -h");
if ret ~= 0
  if ismac
    msg = "brew install zstd";
  else
    msg = "cmake -P cmake/build_zstd.cmake";
  end
  error("need to have Zstd installed: \n install zstd by: \n %s", msg)
end

tar_arc = tempname;

ret = system("zstd -d " + archive + " -o " + tar_arc);
assert(ret == 0, "problem extracting %s", archive)

untar(tar_arc, out_dir)
delete(tar_arc)

end
