Cookiecutter for Makefile-based Python Projects
===============================================
The primary focus of this cookiecutter is a cross-platform (gnu/mingw32)
Makefile.  Apart from that, this cookiecutter is designed to be flexible
and doesn't provide any library boilerplate.  The Makefile itself is
designed to be extensible; the cross-platform Makefile utilities have
been extracted for reuse and modularity.


Options
-------
- | ``module_name``
  | Name of the module.  Should be a valid Python identifier.  Per PEP8,
    module names should be short, all lowercase, and the use of
    underscores is discouraged.

- | ``runnable``
  | Should be yes if the project has a main entry point.

- | ``version``
  | Initial version of the project.

- | ``full_name``
  | Full name of the project author.

- | ``python_version``
  | The best supported Python version for the project.  A minor version
    may be included in the version string, but further specifying a 
    *micro* version is not recommended.

- | ``open_source_license``
  | If your favorite license isn't listed, create a PR.


Files of interest
-----------------
- | ``/.gitignore``
  | Very minimal by default, depending on your project you will probably
    want to add to it.

- | ``/Makefile``
  | Additional make commands can of course be added here.  The
    cookiecutter currently does not include any testing facilities, so
    the Makefile must be edited appropriately.  A placeholder recipe
    exists for this purpose.

- | ``/setup.py``
  | Dependencies should be defined here.

- | ``/requirements/core.pip``
  | Any specific information about the dependencies, such as versions
    and urls, should be defined here.

- | ``/module_name/__main__.py``
  | If your project is runnable, the main entry point should be defined
    here.