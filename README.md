# 🧳 Suitcase

A small command line utility in Swift for packing the contents of a directory into a single file.

## Usage

```sh
suitcase ~/data ~/data/packed-file.txt
```

```sh
suitcase [<directory>] [<outfile>] [--filter <filter>]

ARGUMENTS:
<directory>             The directory that will be parsed.
<outfile>               The name of the file that will be generated. (default: outfile.txt)

OPTIONS:
-f, --filter <filter>   Filter out hidden files. (default: true)
-h, --help              Show help information.
```

## Notes

An entry is defined as its path followed by its contents. Entries are delimited at their start and end ranges by the following unicode scalers:

Name | Scaler
--|--
Start of Text | `U+0002`
End of Text | `U+0003`

The produced file looks something like this:

```
/path/to/file.extension
contents

/path/to/file2.extension
more contents
```
