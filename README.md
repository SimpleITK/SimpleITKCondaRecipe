# SimpleITK Conda Recipe

This repository contains the [Conda build recipe](https://conda.io/docs/building/recipe.html) for SimpleITK.


## Shortcut

Binaries of the current SimpleITK release for Anaconda on various operating systems and Python versions can be found on
[Anaconda Cloud](https://anaconda.org/simpleitk/simpleitk).


## I really do need to build

### Prerequisite software

1. [Cmake](https://cmake.org/) build tool.
2. [Git](https://git-scm.com/) version control system.
3. Compiler (e.g. gcc4.8).

### Process

To build SimpleITK you need to clone this repository and run the build recipe. This will create the package appropriate for your currently active Python version (possibly  2.7):

```
git clone https://github.com/SimpleITK/SimpleITKCondaRecipe.git
cd SimpleITKCondaRecipe
conda build recipe
```

You can also build for a version of Python which is not the currently active one, for example Python 3.4:
```
git clone https://github.com/SimpleITK/SimpleITKCondaRecipe.git
cd SimpleITKCondaRecipe
CONDA_PY=34 conda build recipe
```

Both builds above will use the currently released SimpleITK version which is specified in the [meta.yaml](recipe/meta.yaml) file. If you want another version, such as SimpleITK's current master branch, you will need to make the following two edits to the yaml file.

In the source section change the git tag:
```
git_tag: master
```

In the package section change the version tag:
```
version: "your_custom_version"
```
