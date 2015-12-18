OVERVIEW
========

Cdrd is a simple CDR/SMDR logger daemon.
Main purpose of this daemon is to receive PBX call records at serial port and
store it in plain files. Cdrd can perform basic line filtering to exlude
header/footer lines from output.


REQUIREMENTS
============

Cdrd is developed and tested on FreeBSD, but it should work (with very few
modifications) under any POSIX operating system.


INSTALLATION
============

The included Makefile will install the cdrd daemon for you. Run
~~~
# make install
~~~
to install the cdrd.  Installation will default to /usr/local/bin and
/usr/local/etc, respectively.

FreeBSD users can install cdrd from [port](https://github.com/moisseev/unofficial-freebsd-ports/tree/master/comms/cdrd) (unofficial).

USAGE
=====

For brief help:
~~~
cdrd -h
~~~
See cdrd(1) man page for complete details and cdrd.conf.default file for
configuration options and default values.
