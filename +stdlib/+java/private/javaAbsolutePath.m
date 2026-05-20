function javaPath = javaAbsolutePath(file)
% java.lang.System.getProperty('user.path') is stuck to where Java started

javaPath = javaPathObject(file);

if ~javaPath.isAbsolute()
  % auxiliary variable for Matlab < R2019b
  b = javaPathObject(pwd());
  javaPath = b.resolve(javaPath);
end

end
