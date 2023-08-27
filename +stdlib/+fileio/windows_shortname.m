function short = windows_shortname(p)
%% windows_shortname Retrieves the Windows short name (8.3 character) form
%
%  Example of using a COM server (Scripting.FileSystemObject) in Windows
%
%  References:
%  https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/ch28h2s7
%  https://www.mathworks.com/matlabcentral/fileexchange/48950-short-path-name-on-windows-com-server
%


arguments (Input)
  p (1,1) string
end
arguments (Output)
  short (1,1) string
end

assert(ispc, 'Only available on Windows')

fso = actxserver('Scripting.FileSystemObject');

if isfolder(p)
    short = fso.GetFolder(p).ShortPath;
elseif isfile(p)
    short = fso.GetFile(p).ShortPath;
else
    error('Path "%s" not found', p);
end

delete(fso);

end
