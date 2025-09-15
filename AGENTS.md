# Matlab standard library project

## Project Overview

This is a standard library project for Matlab, designed to provide a collection of commonly used functions and utilities to enhance productivity and streamline development in Matlab.
We generally are not compatible with GNU Octave as the syntax we use is too new to be supported yet by GNU Octave.
The namespace of the project is "stdlib" as indicated by all the project functions being under directory "+stdlib/"

A primary purpose of this project is to use the external language interfaces provided by Matlab to call functions written in other scripting languages IF the language interface is enabled on the specific computer where Matlab is running.
The specific languages supported are Python (namespace stdlib.python under +stdlib/+python/), Java (namespace stdlib.java under +stdlib/+java/), Perl (namespace stdlib.perl under +stdlib/+perl/), .NET (namespace stdlib.dotnet under +stdlib/+dotnet/).
Not every language interface may be available on every system, and the availability of specific language interfaces may depend on the installation and configuration of the Matlab environment.
To detect if a specific language interface is available, we provide functions stdlib.has_python(), stdlib.has_java(), stdlib.has_perl(), stdlib.has_dotnet(), which return logical true or false. These stdlib.has_*() functions are intended to run very quickly, caching the result using Matlab "persistent" variables as needed to make them efficient to call multiple times.

There is a namespace stdlib.sys defined under +stdlib/+sys/ that provided system() calls using the system shell as a last-restort fallback if no external language interface is available on the end user computer running Matlab.
The namespace stdlib.native and stdlib.legacy use plain Matlab code, and allow switching between "modern" and "legacy" implementations of functions as needed.

The self-test functions under "test/" directory can be used by Matlab >= R2019b as invoked by "test_main.m" at the top level of the project directory.
Matlab >= R2022b can alternatively use "buildtool test" to run the self-tests.

## Dev Rules

These rules apply under the namespace "stdlib" (directory +stdlib/) and all its sub-namespaces (subdirectories +stdlib/+*).

- The code syntax must work for Matlab >= R2019b
- The code must not require any Matlab toolboxes, only base Matlab functionality
- Prohibited to use Matlab factory function "isMATLABReleaseOlderThan()" as it is slow and not available for Matlab < R2020b. Instead we use stdlib.matlabOlderThan() which is like 200x faster than isMATLABReleaseOlderThan() and works for Matlab >= R2016b
- When an exception is encountered, we generally desire that the code return an "empty" value of the appropriate type. In certain cases we may throw or rethrow an error.
