function c = canonical(p)
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#getCanonicalPath()

% incorrect result if relative path and any component of path does not exist
% disp("java")
c = javaFileObject(p).getCanonicalPath();

end
