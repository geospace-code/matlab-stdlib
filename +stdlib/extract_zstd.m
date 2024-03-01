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


stdlib.fileio.extract_zstd(archive, out_dir)

end
