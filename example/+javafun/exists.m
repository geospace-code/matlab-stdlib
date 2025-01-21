%% EXISTS does path exist
% Windows: does NOT detect App Execution Aliases
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#exists(java.nio.file.Path,java.nio.file.LinkOption...)
% this takes 2x longer than java.io.File.exists()
% opt = javaLinkOption();
% ok = java.nio.file.Files.exists(java.io.File(p).toPath(), opt);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#exists()
% takes 2x longer than native Matlab isfile || isfolder

function ok = exists(p)
ok = javaFileObject(p).exists();
end