function ok = create_symlink(target, link)

if stdlib.exists(target) && ~stdlib.exists(link)
  createSymbolicLink(link, target);
  ok = true;
else
  ok = false;
end

end
