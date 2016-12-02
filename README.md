# legacy
Legacy - VMS Application
========
_*Customer personnel requesitioning automation for staffing services*_


About
--------
This application holds the personnel staffing client application along with the
administrative web interface to be used by staffing service employees.  It is a
primarily ASP based web application that runs under IIS with MySql and
does perform some tasks with VB subprocesses.


Requirements
--------
 * IIS (Windows Server 2012 or compatible)
 * [Hyper-V](https://en.wikipedia.org/wiki/Hyper-V)


Docs
--------
A document tree is located in the [docs](docs) folder.


Tools
--------
Located in [tools/bin/](tools/bin), these are powershell and command line scripts used to perform
common development tasks such as running unit tests or installing resources.


Getting Started
--------
Run `install` to build and run a development system on your default Hyper-V
guest.  More information can be found in [BUILD.md](BUILD.md).

### Special Note
Currently the build system will not install a default file system so
you must review later and figure out what we're going to put here and how we're going to make it
work, something like:

    install /runonly

In a separate terminal run:

    tools/bin/manage this do that

OR

    tools/bin/cumanage that or this
