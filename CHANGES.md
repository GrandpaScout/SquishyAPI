### As requested by the CC BY-NC-SA 4.0 license:  
This is a modification of [SquAPI by MrSirSquishy](https://github.com/MrSirSquishy/SquishyAPI), a library licensed under
CC BY-NC-SA 4.0.

## Reason for changes:
The purpose of this modification is to split the library into separate "modules" to allow end users to only use the
modules they wish to use. This has the effect of decreasing code size in situations where space is very limited and not
every module is being used by the end user.

## What changes were made:
The main `SquAPI.lua` file now acts as a loader for all of the module files (the `SquAPI_*.lua` files) and if
`require()` is used on it, will load all of the modules at once.  
The loader file is *not* required as separate modules also allow `require()` to be used on them to directly to access
their specific portion of the library.

Many portions of the library have changed to use classes and class instances correctly, stopping needless duplication of
class methods and improving readability.
