function javaPath = javaAbsolutePath(file)
% java.lang.System.getProperty('user.path') is stuck to where Java started

javaPath = javaPathObject(file);

if ~javaPath.isAbsolute()
  b = javaPathObject(pwd());
  javaPath = b.resolve(javaPath);
end

end
