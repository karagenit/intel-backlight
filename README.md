# Intel Backlight

Ruby Gem for setting screen backlight brightness with intel based backlight controllers on linux. 

[![Travis CI](https://img.shields.io/travis/karagenit/intel-backlight.svg?style=flat-square)](https://travis-ci.org/karagenit/intel-backlight)
[![Code Climate](https://img.shields.io/codeclimate/github/karagenit/intel-backlight.svg?style=flat-square)](https://codeclimate.com/github/karagenit/intel-backlight)
[![Gem Version](https://img.shields.io/gem/v/intel-backlight.svg?style=flat-square)](https://rubygems.org/gems/intel-backlight)
[![Gem](https://img.shields.io/gem/dt/intel-backlight.svg?style=flat-square)](https://rubygems.org/gems/intel-backlight)

## Installation

Simply run:

```
$ gem install intel-backlight
```

## Usage

This script can be run as root. Alternatively, you can change the mode of the `/sys/class/backlight/intel_backlight/brightness` file from `644` -> `664` and change the owner from `root:root` -> `root:GROUP` where GROUP is a group your user is a part of. Personally, I used the `adm` group. This will allow you to run the script without root (useful for binding to keyboard shortcuts).

#### Executable

```
# Returns the current brightness
$ backlight
=> 40

# Sets brightness to 50%
$ backlight 50
=> 50

# Increases brightness 10%
$ backlight +10
=> 60

# Decreases brightness 15%
$ backlight -15
=> 45

# Brightness maxes at 100 (and mins at 0)
$ backlight 120
=> 100
```

#### Library

All configurations are done through the core Settings object:

```
config = Backlight::Settings.new
```

You can set/get percentage brightnesses via:

```
config.set(90)
config.get
=> 90
```

Optionaly, you can set the output file, or the file which sets the maximum value via either:

```
config = Backlight::Settings.new(output = ..., max = ...)
config.output(file = ...)
config.max(max = ...)
```

You can also use the `max` method to manually force a maximum integer value for the brightness, rather than reading the value from a file.

## Development Setup

You can run `rake`, which will build the gem, build the documentation into the `doc/` directory, and run the tests & style checker.
