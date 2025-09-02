# https://perldoc.perl.org/variables/$%5EX
# $^X may be relative, so we need to resolve it to an absolute path
# we do not use $Config{perlpath} as that's a build-time variable and is thus
# incorrect when a buildbot was used e.g. Windows Perl from Matlab
#
# https://perldoc.perl.org/Cwd#abs_path
# abs_path is effectively realpath(3)

use Cwd 'abs_path';

print abs_path($^X);
