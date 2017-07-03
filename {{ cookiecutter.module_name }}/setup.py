from setuptools import setup

setup(
    name={{ cookiecutter.module_name|pprint }},
    version={{ cookiecutter.version|pprint }},
    author={{ cookiecutter.full_name|pprint }},
    packages=[{{ cookiecutter.module_name|pprint }}],
    install_requires=[
        # Dependencies are defined here.  Any specific information about
        # the dependencies, such as versions and urls, should be defined
        # in requirements/core.pip.
    ]
)
