function javaPath = javaAbsolutePath(file)
% java.lang.System.getProperty('user.path') is stuck to where Java started

if ischar(file) || isstring(file)
  file = java.io.File(file);
end
javaPath = file.toPath();

if ~javaPath.isAbsolute()
  javaPath = javaPathObject(pwd()).resolve(javaPath);
end

end
