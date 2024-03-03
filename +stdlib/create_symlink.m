function ok = create_symlink(target, link)
%% create_symlink create symbolic link for path

arguments
  target (1,1) string
  link (1,1) string
end

ok = stdlib.fileio.create_symlink(target, link);

end
