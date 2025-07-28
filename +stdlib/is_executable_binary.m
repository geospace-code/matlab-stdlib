function y = is_executable_binary(filename)
% IS_EXECUTABLE_BINARY Check if a file is an executable binary by examining magic numbers
%
% NOTE: on Unix-like operating systems, often times what users run thinking
% it's a "program" is actually a shell script invoking a binary with
% options.
%    fullfile(matlabroot, 'bin/matlab')
% is a shell script and thus is FALSE for this function.

y = false;

fid = fopen(filename, 'rb');
if fid < 0, return, end

N = 4;
if ispc(), N = 2; end

magic = fread(fid, N, 'uint8').';
fclose(fid);
if numel(magic) < N, return, end

if ispc()
    y = isequal(magic(1:2), [0x4d, 0x5a]);
    % Check for PE magic number (MZ)
elseif ismac()
    % Check for Mach-O magic number
    feedface = [0xFE, 0xED, 0xFA, 0xCE];
    feedfacf = [0xFE, 0xED, 0xFA, 0xCF];
    cafebabe = [0xCA, 0xFE, 0xBA, 0xBE];
    cafebabf = [0xCA, 0xFE, 0xBA, 0xBF];
    for a = {feedface, fliplr(feedface), ...
             feedfacf, fliplr(feedfacf), ...
             cafebabe, fliplr(cafebabe), ...
             cafebabf, fliplr(cafebabf)}

       y = isequal(magic, a{1});
       if y, return, end
    end
else
    % Check for ELF magic number (0x7f followed by 'ELF')
    y = isequal(magic, [0x7f, 0x45, 0x4c, 0x46]);
end

end
