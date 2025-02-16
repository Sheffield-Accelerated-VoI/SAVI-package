# How to install the SAVI R package from GitHub

 
This is an alternative to using the online version at https://savi.shef.ac.uk/SAVI/.

If you have any difficulties downloading and running the SAVI R Package please let us know via savi@sheffield.ac.uk.
 
These instructions are for Windows, Mac and Linux

# Initial set up (this only needs to be done once)

1) Download R from http://cran.rstudio.com/ and install.

 
2) Install the devtools package from CRAN, either by typing: **`install.packages('devtools') `** into the console, or via the Tools > Install Packages menu if using RStudio .

 
3) Load the devtools package via the command: **`library(devtools)`**

Windows users may be prompted to install Rtools. You do not need Rtools to install SAVI.

 
4) Install the SAVI package via:    **`install_github('Sheffield-Accelerated-VoI/SAVI-package')`**

 
The SAVI report download feature requires Pandoc. Pandoc can be downloaded and installed from http://pandoc.org/.

 
Pandoc is not essential for the rest of SAVI to work.

################
# Running SAVI #
################

 
Type the following two lines into the console:

**`library(SAVI)`**

 
**`SAVI()`**

 
SAVI should open in your machine's default web browser. The analysis is processed entirely on your own machine.


*Mark Strong*

*23rd November 2015*

 
