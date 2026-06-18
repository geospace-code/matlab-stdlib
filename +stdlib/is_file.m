%% IS_FILE Determine if path is a file
%
% left for backward compatibility

function y = is_file(fpath)
arguments
  fpath {mustBeTextScalar}
end

y = isfile(fpath);

end
