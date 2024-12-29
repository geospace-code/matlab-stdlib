# Matlab-Stdlib Java implementation

Matlab has used Java since before Matlab R2006a.
GNU Octave also can [use Java](https://docs.octave.org/latest/Set-up-the-JVM.html).
Matlab-Stdlib uses only factory JRE classes.

Tell JVM version

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

From before Matlab R2019b to at least Matlab R2024b, the Matlab factory Java version is 1.8, which is adequate for all Matlab-stdlib functionality.

If desired (not used by Matlab-stdlib), one can use non-factory Java classes in
[Matlab](](https://www.mathworks.com/help/matlab/matlab_external/static-path-of-java-class-path.html))
and
[GNU Octave](https://docs.octave.org/interpreter/Making-Java-Classes-Available.html).


## Configure Matlab JVM

The Matlab Java interface is like other Matlab external languages such as Python.
The Matlab default
[JVM can be configured](https://www.mathworks.com/help/matlab/matlab_external/configure-your-system-to-use-java.html)
to
[compatible JRE](https://www.mathworks.com/support/requirements/language-interfaces.html)
across
[Matlab versions](https://www.mathworks.com/support/requirements/openjdk.html)
by using the
[jenv](https://www.mathworks.com/help/matlab/ref/jenv.html)
Matlab function.

Tell JVM details:

```matlab
jenv
```

For example, to use the
[JDK 17 on macOS](https://www.oracle.com/java/technologies/downloads/#jdk17-mac)
download and extract the ARM64 Compressed Archive.
Tell Matlab to use this JDK from the Matlab console by:

```matlab
jenv("/path/to/jdk-17/Contents/Home")
```

To
[revert back to the factory JRE](https://www.mathworks.com/help/matlab/ref/matlab_jenv.html)
if Matlab can't start or has problems, from system Terminal (not within Matlab):

```sh
matlab_jenv factory
```

## Configure GNU Octave JVM

GNU [Octave JVM](https://docs.octave.org/latest/Set-up-the-JVM.html)
can be configured with the JAVA_HOME environment variable.
Some install packages don't include Java.
For example, with Homebrew:

```sh
brew install octave openjdk
```
