%% EXISTS does path exist
%
%%% Inputs
% * p: path to check
%%% Outputs
% * ok: true if exists
%

function ok = exists(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Files.html#exists(java.nio.file.Path,java.nio.file.LinkOption...)
% this takes 2x longer than java.io.File.exists()
% opt = java.nio.file.LinkOption.values;
% ok = java.nio.file.Files.exists(java.io.File(p).toPath(), opt);

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#exists()
% takes 2x longer than native Matlab isfile || isfolder
  ok = java.io.File(p).exists();
else
  ok = isfile(p) || isfolder(p);
end


end
