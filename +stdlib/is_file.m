%% IS_FILE Determine if path is a file
%
% for Matlab < R2017b that doesn't have isfile(), note that exist() also looks
% on the Matlab path.

function y = is_file(fpath)

try
  y = isfile(fpath);
catch e
  if strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    y = exist(fpath,'file') == 2;
  else
    rethrow(e)
  end
end

end
