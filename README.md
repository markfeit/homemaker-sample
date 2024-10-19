# Homemaker Sample Configuration

This is a sample configurationf for use with
[Homemaker](https://github.com/markfeit/homemaker-core).


## Prerequisites

Your system mut have the following installed:

 * A POSIX-compliant shell (Bourne shell or BASH)
 * A POSIX-compliant M4
 * Git
 * GNU Make
 * Rsync


## Configuration

See `[home/README.md](home/README.md)` for further details on
configuring files to be installed **before using any of the `make`
targets listed below.


## Installation

**NOTE:** This sample is in a safe state that will not overwrite
  anything in `$HOME` and writes into `./installed`.  When ready to
  install files in your home directory, edit the `Makefile` and
  comment out the line that sets `SAFE`.

To install the files in `home`, run `make install`.
