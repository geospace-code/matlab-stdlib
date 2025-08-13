# Matlab-Stdlib Java functions

Some Matlab-Stdlib functions use the factory JRE, and have been tested with JVM versions 8 and 17 and newer.

In general, Java's java.io.File() and java.nio.file don't work with Windows App Execution Aliases.
However, Matlab's intrinsic file functions do work with Windows App Execution Aliases.

Matlab's Java interface was
[introduced in Matlab 6.0 R12](http://www.ece.northwestern.edu/local-apps/matlabhelp/base/relnotes/matlab/matlab124.html#20684)
in the year 2000.
Matlab-Stdlib uses only factory JRE classes where intrinsic Matlab code isn't easily capable of provided the needed algorithms.

Tell JVM version:

```matlab
version("-java")
```

Get the Java API level:

```matlab
stdlib.java_api()
```

Get the Java vendor:

```matlab
stdlib.java_vendor()
```

Get the Java version:

```matlab
stdlib.java_version()
```

From before Matlab R2019b to at least Matlab R2025a, the Matlab factory Java version is 1.8, which is adequate for most Matlab-stdlib functionality.

Java won't be available if Matlab was started with
[-nojvm](https://www.mathworks.com/help/matlab/matlab_env/commonly-used-startup-options.html).
This
[CI job](https://github.com/geospace-code/matlab-stdlib/actions/workflows/ci-nojvm.yml)
tests without Java.

If desired (not used by Matlab-stdlib), one can use non-factory Java classes in
[Matlab](https://www.mathworks.com/help/matlab/matlab_external/static-path-of-java-class-path.html).

## Configure Matlab JVM

The Matlab Java interface is like other Matlab external languages such as Python.
The Matlab default
[JVM can be configured](https://www.mathworks.com/help/matlab/matlab_external/configure-your-system-to-use-java.html)
to a compatible Java library by using the
[jenv](https://www.mathworks.com/help/matlab/ref/jenv.html)
Matlab function.
Matlab vs. Java
[version compatibility table](https://www.mathworks.com/support/requirements/openjdk.html).

Tell JVM details:

```matlab
je = jenv

% Tell the JAVA_HOME directory
disp(je.Home)
```

For example, to use the
[JDK 17 on macOS](https://www.oracle.com/java/technologies/downloads/#jdk17-mac)
download and extract the ARM64 Compressed Archive.
Tell Matlab to use this JDK from the Matlab console by:

```matlab
jenv("/path/to/jdk-17/Contents/Home")
```

Or for the Amazon Corretto JDK 11 on macOS:

```matlab
jenv("/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home/")
```

On Windows, obtain OpenJDK with WinGet, which installs under "$Env:ProgramFiles/Microsoft/jdk-*":

```sh
winget install Microsoft.OpenJDK.11
```

To
[revert back to the factory JRE](https://www.mathworks.com/help/matlab/ref/matlab_jenv.html)
if Matlab can't start or has problems, from system Terminal (not within Matlab):

```sh
matlab_jenv factory
```
