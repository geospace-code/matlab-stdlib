%% IS_URL is true if the string is a URL.
% e.g. https://example.invalid is true

function y = is_url(s)
arguments
  s {mustBeTextScalar}
end

try
  y = startsWith(s, alphanumericsPattern + "://");
catch e
  % Matlab < R2020b
  if ~strcmp(e.identifier, "MATLAB:UndefinedFunction") && ...
    ~strcmp(e.identifier, "Octave:undefined-function")
      rethrow(e)
  end

  % https://www.mathworks.com/help/matlab/import_export/work-with-remote-data.html

  y = startsWith(s, "http://") || startsWith(s, "https://") || ...
      startsWith(s, "ftp://") || startsWith(s, "file://") || ...
      startsWith(s, "s3://") || startsWith(s, "hdfs://") || ...
      startsWith(s, "wasbs://");
end

end

%!assert (is_url("http://example.com"), true)
%!assert (is_url("//server"), false)
