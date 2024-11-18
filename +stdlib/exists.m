%% EXISTS does path exist
%
%%% Inputs
% * p: path to check
%%% Outputs
% * ok: true if exists
%
% Ref: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/File.html#exists()

function ok = exists(p, use_java)
arguments
  p (1,1) string
  use_java (1,1) logical = false
end

if use_java
% Java takes 2x to 10x as long as intrinsic way worst case
% the intrinsic way above is at least not slower

  ok = java.io.File(p).exists();
else
  ok = isfile(p) || isfolder(p);
end


end
