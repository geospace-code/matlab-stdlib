# Using Java in standard library for Matlab

Java-based functions should work with any
[Java version compatible with the Matlab release](https://www.mathworks.com/support/requirements/openjdk.html).
Matlab in general does not bundle Java from the factory installation, but Java may have been installed by a system administrator.
One cannot assume that Java will or will not be present on a given Matlab installation.

Matlab's
[Java language interface](https://www.mathworks.com/help/matlab/using-java-libraries-in-matlab.html)
was
[introduced in Matlab 6.0 R12](http://www.ece.northwestern.edu/local-apps/matlabhelp/base/relnotes/matlab/matlab124.html#20684)
in the year 2000.
Our optional Java backend functions use only factory Java class--no third-party Java libraries are used.

## Java backend diagnostic functions

Tell Java Virtual Machine (JVM) version:

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

Tell JVM details:

```matlab
je = jenv

% Tell the JAVA_HOME directory
disp(je.Home)
```

As general information (not used by Matlab-stdlib), non-factory Java classes can be used in
[Matlab](https://www.mathworks.com/help/matlab/matlab_external/static-path-of-java-class-path.html).

## Configure Matlab JVM

The Matlab Java interface is like other Matlab external languages such as Python.
Matlab
[JVM can be configured](https://www.mathworks.com/help/matlab/matlab_external/configure-your-system-to-use-java.html)
to a compatible Java library by using the
[jenv](https://www.mathworks.com/help/matlab/ref/jenv.html)
Matlab function.

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
[revert back to the default JRE](https://www.mathworks.com/help/matlab/ref/matlab_jenv.html)
if Matlab can't start or has problems, from system Terminal (not within Matlab):

```sh
matlab_jenv factory
```
