function r = cmake_atleast(min_version)
arguments
  min_version (1,1) string {mustBeNonzeroLengthText}
end

[ret, msg] = system("cmake --version");

assert(ret==0, "problem getting CMake version " + msg)

match = regexp(msg, "(?<=cmake version )(\d+\.\d+\.\d+)", 'match');

r = stdlib.version_atleast(match{1}, min_version);

end
