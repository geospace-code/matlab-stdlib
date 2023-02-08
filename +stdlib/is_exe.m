function ok = is_exe(file)
%% is_exe(file)
% is a file executable, as per its filesystem attributes
% does not actually try to run the file.
%%% Inputs
% * file: filename
%%% Outputs
% * ok: boolean logical

arguments
  file string {mustBeScalarOrEmpty}
end

ok = stdlib.fileio.is_exe(file);

end
