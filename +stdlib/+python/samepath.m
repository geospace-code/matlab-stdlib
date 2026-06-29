function y = samepath(path1, path2)

if stdlib.has_python()
   y = py.os.path.samefile(path1, path2);
else
   y = missing;
end

end
