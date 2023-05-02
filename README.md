# FIREHOSE

This repository contains IDL routines for reduction of data taken with the Magellan/FIRE infrared spectrograph.  Documentation on their use may be found at the following MIT wiki:

https://wikis.mit.edu/confluence/display/FIRE/FIRE+Data+Reduction

This version of the FIREHOSE pipeline supersedes another version currently posted on github under the name firehose_v2.  That version is not supported by the instrument team.  Many of its functions will work, but the current repository posted here contains a number of small fixes uncovered over the years, and will be the version of record going forward.

FIREHOSE has been tested on a wide variety of observations and object types with good result. However some users, especially those that prefer python, may wish to experiment with the pypeit software suite which has also successfully processed FIRE data.  However pypeit is somewhat optimized for quasar spectroscopy and has special telluric correction methods tailored specifically to that SED type.

FIREHOSE requires installation of the xidl software suite as well as aging SDSS IDL utilities.  The website linked above provides instructions on how to obtain and compile these tools, though some are not well supported, especially on OSX in Catalina or higher.

## Installation
1. Go to the directory where IDL packages are installed (hereafter, `$IDL_LOCAL`).
2. Download `idlutils`, `idlspec2d`, `xidl` and `FIREHOSE`:
    - `svn co https://svn.sdss.org/public/repo/sdss/idlutils/trunk/ idlutils` (v5_5_36)
    - `svn co https://svn.sdss.org/public/repo/eboss/idlspec2d/trunk idlspec2d` (v5_13_2)
    - `git clone https://github.com/RuiningZHAO/xidl.git` (version unknown)
    - `git clone https://github.com/RuiningZHAO/FIREHOSE.git` or `git clone https://github.com/rasimcoe/FIREHOSE.git` (version unknown)
3. Include the following environment variables in bash profile:
    ```
    # idlutils
    export IDLUTILS_DIR=$IDL_LOCAL/idlutils
    export IDL_PATH=+$IDLUTILS_DIR/goddard/pro:+$IDLUTILS_DIR/pro:$IDL_PATH
    # idlspec2d
    export IDLSPEC2D_DIR=$IDL_LOCAL/idlspec2d
    export IDL_PATH=+$IDLSPEC2D_DIR/:$IDL_PATH
    # xidl
    export XIDL_DIR=$IDL_LOCAL/xidl
    export IDL_PATH=+$XIDL_DIR/:$IDL_PATH
    # firehose
    export FIRE_DIR=$IDL_LOCAL/FIREHOSE
    export IDL_PATH=+$FIRE_DIR/:$IDL_PATH
    ```
4. Compile `idlutils`, `idlspec2d`, and `xidl`. Basically, only two commands (`$IDLUTILS_DIR/bin/evilmake clean` and `$IDLUTILS_DIR/bin/evilmake all`) are needed (see [here](https://www.ucolick.org/~xavier/IDL/xidl_install.html) for details).
5. Type `firehose_ld` at the IDL command prompt. This should bring up a GUI for data reduction.
6. Done!

## Note
1. This repo is forked from [rasimcoe/FIREHOSE](https://github.com/rasimcoe/FIREHOSE.git).
2. Only [README](README.md) is modified.
3. The versions of `idlutils`, `idlspec2d` and `xidl` may not be the latest but they support `FIREHOSE` well on Ubuntu 22.04.
4. Consult the following webpages for more help on installation:
    - https://wikis.mit.edu/confluence/display/FIRE/FIREHOSE+installation+instructions
    - http://web.mit.edu/~burles/www/MIKE/mike_install.html (also contains download links of `idlutils`, `idlspec2d`, and `xidl`)
    - https://www.ucolick.org/~xavier/IDL/xidl_install.html
5. Consult the following webpage for the usage of `FIREHOSE`:
    - https://wikis.mit.edu/confluence/display/FIRE/FIRE+Data+Reduction