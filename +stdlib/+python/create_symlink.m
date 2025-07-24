function ok = create_symlink(target, link)

try
  py.os.symlink(target, link);
  ok = true;
catch e
  warning(e.identifier, "%s", e.message)
  ok = false;
end

end
