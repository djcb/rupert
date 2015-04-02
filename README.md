Rupert, the GObject Boilerplate Generator
=========================================

Introduction
------------

[GObjects](http://en.wikipedia.org/wiki/GObject) implement a very
useful object-system for the C programming language.

They are easy to use, but writing them can be a bit tedious due to the
amount of boiler-plate code. So, it's only natural to create a little
tool to do that for you.

Rupert
------

_Rupert_ is Perl script that does just that. Rupert is not the first
of its kind, but it is the one I'm currently using. It's named after
Rupert the Monkey, a well-known character from the early days of the
GNOME project.

Usage
-----

Easy. Pass it the prefix and full name of the GObject you'd like to
create.

```
cd rupert
./rupert.pl Funky FunkyMonkey
```

creates `funky-monkey.c` and `funky-monkey.h`, including some example
methods, a property and a signal.

Of course, you must still _understand_ GObject for this to be
useful. But it saves some typing.

Licence
-------

Rupert is released under the terms of the GPLv3, but the code it generates
is not - you can put that under any license you want.
