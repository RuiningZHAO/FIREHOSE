# FIREHOSE

This repository contains IDL routines for reduction of data taken with the Magellan/FIRE infrared spectrograph.  Documentation on their use may be found at the following MIT wiki:

https://wikis.mit.edu/confluence/display/FIRE/FIRE+Data+Reduction

This version of the FIREHOSE pipeline supersedes another version currently posted on github under the name firehose_v2.  That version is not supported by the instrument team.  Many of its functions will work, but the current repository posted here contains a number of small fixes uncovered over the years, and will be the version of record going forward.

FIREHOSE has been tested on a wide variety of observations and object types with good result. However some users, especially those that prefer python, may wish to experiment with the pypeit software suite which has also successfully processed FIRE data.  However pypeit is somewhat optimized for quasar spectroscopy and has special telluric correction methods tailored specifically to that SED type.

FIREHOSE requires installation of the xidl software suite as well as aging SDSS IDL utilities.  The website linked above provides instructions on how to obtain and compile these tools, though some are not well supported, especially on OSX in Catalina or higher.

## Installation
### Download
1. idlutils (v5_5_36)
```svn co https://svn.sdss.org/public/repo/sdss/idlutils/trunk/ idlutils```
2. idlspec2d (v5_13_2)
```svn co https://svn.sdss.org/public/repo/eboss/idlspec2d/trunk idlspec2d```
3. xidl (version unknown)
```git clone https://github.com/RuiningZHAO/xidl.git```
4. FireHose (version unknown)
```git clone https://github.com/RuiningZHAO/FIREHOSE.git```
or
```git clone https://github.com/rasimcoe/FIREHOSE.git```
