# SimpleITK Conda Recipe

This repository contains the [Conda build recipe](https://conda.io/docs/building/recipe.html) for SimpleITK.

## Anaconda Cloud Compiled Binaries

[![Anaconda-Server Badge](https://anaconda.org/simpleitk/simpleitk/badges/installer/conda.svg)](https://anaconda.org/simpleitk/simpleitk)
[![Anaconda-Server Badge](https://anaconda.org/simpleitk/simpleitk/badges/version.svg)](https://anaconda.org/simpleitk/simpleitk)
[![Anaconda-Server Badge](https://anaconda.org/simpleitk/simpleitk/badges/downloads.svg)](https://anaconda.org/simpleitk/simpleitk)

Binaries of the current SimpleITK release for Anaconda on various operating systems and Python versions can be found on
Anaconda cloud's [SimpleITK channel](https://anaconda.org/simpleitk/simpleitk).

```
conda install -c simpleitk simpleitk
```


## I really do need to build

### Prerequisite software

1. [Anaconda](https://www.continuum.io/) Python distribution with conda-build installed:
   ```
   conda install conda-build
   ```
   The [Conda documentation](https://conda.io/docs/building/recipe.html) also recommends updating the installation if you have an older install:

   ```
   conda update conda
   conda update conda-build
   ```
2. [Git](https://git-scm.com/) version control system.
3. Compiler (e.g. gcc4.8).  
On Windows Visual C++ 14.0 is the supported version for Python 3.5-7.  It comes with Visual Studio 2015.  More recent versions of Visual Studio will not work by default.  
Links to download VS2015 can be found [here](https://stackoverflow.com/questions/44290672/how-to-download-visual-studio-community-edition-2015-not-2017).

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
conda build --python 3.4 recipe
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
### Installation

To install the package and all its dependencies we need to point conda to a channel, this can be a channel on [Anaconda Cloud](https://anaconda.org) or a local [custom channel](https://conda.io/docs/custom-channels.html).

In general, the directory where the package was created serves as a custom channel and you install it as follows:
```
conda install --use-local simpleitk
```

If you have multiple versions of the package you can specify the version of simpleitk as shown at the top of this page.

### Advanced - managing multiple local versions

Using the --use-local option is equivalent to
```
conda install -c file://your_anaconda_directory/conda-bld simpleitk
```
You can also create your own custom channel, add the package to the relevant subdirectory based on your platform, and update the index. For example on OSX:
```
mkdir -p my-local-conda-channel/osx-64
cp simpleitk-*.tar.bz2 my-local-conda-channel/osx-64/
conda index my-local-conda-channel/osx-64/
```
Then install from that custom channel:
```
conda install -c file://my-local-conda-channel simpleitk
```

If the package is not found in the local channel conda will attempt to retrieve it from other channels. For example if you have the simpleitk channel listed in your .condarc file you may get a simpleitk package, not necessarily the one you wanted, your local version which wasn't found.
