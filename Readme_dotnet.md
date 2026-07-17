# .NET from Matlab

[.NET](https://www.mathworks.com/help/matlab/call-net-from-matlab.html)
support in MATLAB when a compatible
[.NET SDK is installed](https://www.scivision.dev/matlab-dotnet-linux-macos)
includes:

* Windows: all supported Matlab releases
* Linux or macOS: R2024b and newer

## macOS .NET with Matlab

```sh
brew install dotnet
```

in Matlab

```matlab
edit(fullfile(userpath, 'startup.m'))
```

add the lines

```matlab
setenv('HOMEBREW_PREFIX', '/opt/homebrew')
setenv('DOTNET_ROOT', [getenv('HOMEBREW_PREFIX') '/opt/dotnet/libexec'])
```

restart Matlab, then issue the one-time setup command [
[dotnetenv](https://www.mathworks.com/help/matlab/ref/dotnetenv.html)

```matlab
dotnetenv("core", Version="10")
```

where "10" must match the installed .NET SDK major version from

```sh
dotnet --list-sdks
```


## Windows .NET with Matlab

Windows normally has .NET already available with Matlab, but it may be an old .NET version lacking newer features.
A current .NET SDK can be installed using winget

```powershell
winget search Microsoft.DotNet.SDK
```

To find the installed .NET SDK file location:

```powershell
dotnet --list-sdks
```

since the usual `winget list Microsoft.DotNet.SDK --details` might not show the installed location.

In Matlab

```matlab
edit(fullfile(userpath, 'startup.m'))
```

add the location obtained from `dotnet --list-sdks` to the `DOTNET_ROOT` environment variable, for example:

```matlab
setenv('DOTNET_ROOT', 'C:/Program Files/dotnet/sdk')
```

restart Matlab, then issue the one-time setup command

```matlab
dotnetenv("core", Version="10")
```

where "10" must match the installed .NET SDK major version from

```powershell
dotnet --list-sdks
```
