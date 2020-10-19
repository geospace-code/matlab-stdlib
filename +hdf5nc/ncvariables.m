function names = ncvariables(filename)
% get dataset names in a file
%
% parameters
% ----------
% file: filename
%
% returns
% -------
% names: variable names

arguments
  filename (1,1) string
end

finf = ncinfo(expanduser(filename));
ds = finf.Variables(:);
names = string({ds(:).Name});

end % function
