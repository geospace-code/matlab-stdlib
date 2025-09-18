# Matlab standard library project

## Project Overview

This is a standard library project for Matlab, designed to provide a collection of commonly used functions and utilities to enhance productivity and streamline development in Matlab.
The namespace of the project is "stdlib" as indicated by all the project functions being under directory "+stdlib/"

A primary purpose of this project is to use the external language interfaces provided by Matlab to call functions written in other scripting languages IF the language interface is enabled on the specific computer where Matlab is running.
The specific languages supported are Python (namespace stdlib.python under +stdlib/+python/), Java (namespace stdlib.java under +stdlib/+java/), Perl (namespace stdlib.perl under +stdlib/+perl/), .NET (namespace stdlib.dotnet under +stdlib/+dotnet/).
Not every language interface may be available on every system, and the availability of specific language interfaces may depend on the installation and configuration of the Matlab environment.
To detect if a specific language interface is available, we provide functions stdlib.has_python(), stdlib.has_java(), stdlib.has_perl(), stdlib.has_dotnet(), which return logical true or false. These stdlib.has_*() functions are intended to run very quickly, caching the result using Matlab "persistent" variables as needed to make them efficient to call multiple times.

There is a namespace stdlib.sys defined under +stdlib/+sys/ that provided system() calls using the system shell as a last-restort fallback if no external language interface is available on the end user computer running Matlab.
The namespace stdlib.native and stdlib.legacy use plain Matlab code, and allow switching between "modern" and "legacy" implementations of functions as needed.

The self-test functions under "test/" directory can be used by Matlab >= R2017a as invoked by "test_main.m" at the top level of the project directory.
Matlab >= R2022b can alternatively use "buildtool test" to run the self-tests.

Key limitations to minimum Matlab version include:

* R2017b: builtin isfolder(), isfile() available
* R2017b: fileparts() supports string type. fileparts() is used in many places in the code as it's 5-10x faster than regexp() for filename parsing.
* R2018a: fileattrib(), fullfile() supports string type
* R2018a: mfilename('fullpath') tells the full path to the matlab .m file currently running (empty for older Matlab)
* R2019b: function argument validation block "arguments"

## GNU Octave compatibility

Numerous functions are also compatible with GNU Octave, but Octave is not a primary target of this project.
In particular, using GNU Octave with functions having a backend as shown in [API.md](./API.md), directly use the "stdlib.sys" namespace as Octave doesn't have built-in strings yet to support auto-backend selection.

## Dev Rules

These rules apply under the namespace "stdlib" (directory +stdlib/) and all its sub-namespaces (subdirectories +stdlib/+*).

- The code syntax must work for Matlab >= R2019b (preferably Matlab >= R2017b)
- The code must not require any Matlab toolboxes, only base Matlab functionality
- Prohibited to use Matlab factory function "isMATLABReleaseOlderThan()" as it is slow and not available for Matlab < R2020b. Instead we use stdlib.matlabOlderThan() which is like 200x faster than isMATLABReleaseOlderThan() and works for Matlab >= R2016b
- When an exception is encountered, we generally desire that the code return an "empty" value of the appropriate type. In certain cases we may throw or rethrow an error.
- where the output represents a filesystem path, the output should be a string type if any input is string type, otherwise char type.

## Dev notes

- The code in stdlib.python_version, stdlib.has_python has distinct use of persistent variables, we have carefully reviewed it and are satified with its performance and correctness regarding persistent variables.
- I do not wish to implement cache reset in python_version() or perl_version().

The code in the following list of stdlib.* functions is of the highest priority to be correct and efficient, as it's fundamental to correct filesystem operations. These functions are used by many other functions in this and other projects.

```
absolute(), canonical(), cpu_count(), exists(), expanduser(), file_checksum(), file_size(), filename(), h5save(), h5exists(), h5size(), is_absolute(), is_exe, join(), makedir(), parent(), posix(), resolve(), root(), samepath(), stem(), suffix(), with_suffix()
```
