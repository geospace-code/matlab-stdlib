# https://perldoc.perl.org/variables/$%5EX
# $^X may be relative, so we need to resolve it to an absolute path
# we do not use $Config{perlpath} as that's a build-time variable and is thus
# incorrect when a buildbot was used e.g. Windows Perl from Matlab
#
# Cwd::abs_path is not appropriate as it does not actually work like realpath(3)
#
# does not interact with filesystem:
# https://perldoc.perl.org/File::Spec#file_name_is_absolute
#
# works like which() but platform-independent
# https://perldoc.perl.org/IPC::Cmd#$path-=-can_run(-PROGRAM-);

use File::Spec;
use IPC::Cmd 'can_run';

my $perl_exe = $^X;
my $perl_path;

if (File::Spec->file_name_is_absolute($perl_exe)) {
  $perl_path = $perl_exe;
} else {
  $perl_path = can_run($perl_exe);
}

print $perl_path;
