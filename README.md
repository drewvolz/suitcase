# 🧳 Suitcase

A small command line utility in Swift for:
* Packing the contents of a directory into a single JSON file 
* Unpacking a file back into a directory structure

## Usage

### Pack

```sh
suitcase pack ~/data ~/data/packed-file.txt
```

```sh
OVERVIEW: Pack a directory of files into a single file.

USAGE: suitcase pack [<directory>] [<outfile>] [--filter <filter>]

ARGUMENTS:
<directory>             The directory that will be parsed.
<outfile>               The name of the file that will be generated. (default: outfile.txt)

OPTIONS:
-f, --filter <filter>   Filter out hidden files. (default: true)
-h, --help              Show help information.
```

### Unpack

```sh
suitcase unpack ~/data/packed-file.txt
```

```sh
OVERVIEW: Unpack a packed file back into a directory.

USAGE: suitcase unpack [<infile>] [--filter <filter>]

ARGUMENTS:
<infile>                The packed file that will be unpacked.

OPTIONS:
-f, --filter <filter>   Filter out hidden files. (default: true)
-h, --help              Show help information.
```
