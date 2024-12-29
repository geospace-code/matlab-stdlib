f = stdlib.absolute("Readme.md");
link = "alsoread.md";

perms = stdlib.get_permissions(f);

pp = java.nio.file.attribute.PosixFilePermissions.fromString(perms);

fp = java.nio.file.attribute.PosixFilePermissions.asFileAttribute(pp);

tp = java.io.File(f).toPath();
lp = java.io.File(link).toPath();

java.nio.file.Files.createSymbolicLink(lp, tp, fp);
% this fails with No method 'java.nio.file.Files.createSymbolicLink' with matching signature found.
