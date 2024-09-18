# Matlab-Stdlib Java implementation

Matlab has used Java extensively internally for over a decade.
While the "New Desktop" is HTML and JavaScript based, and already other new GUI elements in Matlab were not using Java, the underlying JRE interface is treated at least like other Matlab external languages such as C++ and Python.
Matlab-Stdlib uses only factory JRE classes.

For reference, it is readily possible in general to use non-factory
[Java classes](https://www.mathworks.com/help/matlab/matlab_external/static-path-of-java-class-path.html)
in Matlab.

The Matlab-Stdlib package uses Java functions throughout, including:

* [java.lang.ProcessBuilder](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/lang/ProcessBuilder.html)
* [java.lang.System](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/lang/System.html)
* [java.nio.file](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/nio/file/Files.html)
* [java.io.File](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/io/File.html)
* [java.net.InetAddress](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/net/InetAddress.html)
* [java.lang.management.ManagementFactory](https://docs.oracle.com/en/java/javase/21/docs/api/jdk.management/com/sun/management/OperatingSystemMXBean.html)
* [java.security.MessageDigest](https://docs.oracle.com/en/java/javase/22/docs/api/java.base/java/security/MessageDigest.html)

## Java version

Get the JVM version with

```matlab
version("-java")
```

The Matlab default
[JVM can be configured](https://www.mathworks.com/help/matlab/matlab_external/configure-your-system-to-use-java.html)
to
[compatible JRE](https://www.mathworks.com/support/requirements/language-interfaces.html)
across
[Matlab versions](https://www.mathworks.com/support/requirements/openjdk.html)
by using the
[jenv](https://www.mathworks.com/help/matlab/ref/jenv.html)
Matlab function.

For example, to use the
[JDK 17 on macOS](https://www.oracle.com/java/technologies/downloads/#jdk17-mac)
download and extract the ARM64 Compressed Archive.
Tell Matlab to use this JDK from the Matlab console by:

```matlab
jenv("/path/to/jdk-17/Contents/Home")
```

To
[revert back to the factory JRE](https://www.mathworks.com/help/matlab/ref/matlab_jenv.html)
if Matlab can't start or has problems, from system Terminal do:

```sh
matlab_jenv factory
```
