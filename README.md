# Intel Backlight

Ruby Gem for setting screen backlight brightness with intel based backlight controllers on linux. 

## Installation

Simply run:

```
$ gem install intel-backlight
```

## Usage

This script can be run as root. Alternatively, you can change the mode of the `/sys/class/backlight/intel_backlight/brightness` file from `644` -> `664` and change the owner from `root:root` -> `root:GROUP` where GROUP is a group your user is a part of. Personally, I used the `adm` group. This will allow you to run the script without root (useful for binding to keyboard shortcuts).

## Development Setup

You can run `rake`, which will build the gem, build the documentation into the `doc/` directory, and run the tests & style checker.
