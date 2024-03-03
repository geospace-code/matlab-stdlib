function ok = is_exe(file)
%% is_exe(file)
% is a file executable, as per its filesystem attributes
%%% Inputs
% * file: filename
%%% Outputs
% * ok: boolean logical

arguments
  file (1,1) string
end

ok = stdlib.fileio.is_exe(file);

end
