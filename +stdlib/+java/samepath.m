%% JAVA.SAMEPATH are inputs the same path

function y = samepath(path1, path2)

f1 = java.io.File(path1);
f2 = java.io.File(path2);

if f1.exists() && f2.exists()
  p1 = file2absPath(f1);
  p2 = file2absPath(f2);
  y = java.nio.file.Files.isSameFile(p1, p2);
else
  y = false;
end

end


function jpath = file2absPath(jfile)
% java.lang.System.getProperty('user.path') is stuck to where Java started

jpath = jfile.toPath();

if ~jfile.isAbsolute()
  jpath = javaPathObject(pwd()).resolve(jpath);
end

end
