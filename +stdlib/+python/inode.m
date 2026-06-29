function i = inode(file)

if stdlib.has_python()
  i = py.os.stat(file).st_ino;
  if i.bit_length() <= 64
    i = uint64(i);
  else
    % use string instead of char for equality checks like in samepath()
    i = string(py.str(i));
  end
else
  i = missing;
end

end
