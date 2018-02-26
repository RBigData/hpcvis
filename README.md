# hpcvis

* **Version:** 0.2-1
* **URL**: https://github.com/RBigData/hpcvis
* **License:** [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** See section below.


The **hpcvis** package offers powerful, reproducible visualization utilities with simple syntax for MPI profiler data and hardware performance counter data.  

For MPI profiling, see the [pbdPROF](https://github.com/RBigData/pbdPROF) package, and for performance counter data, see the  [pbdPAPI](https://github.com/RBigData/pbdPAPI) package.



## Installation

The development version is maintained on GitHub, and can easily be installed by any of the packages that offer installations from GitHub:

```r
devtools::install_github("RBigData/hpcvis")
ghit::install_github("RBigData/hpcvis")
remotes::install_github("RBigData/hpcvis")
```



## Usage

Since the package is separated into two separate components (MPI and performance counter profiling), it is difficult to show off/motivate the package in a few lines.  So you are strongly encouraged to see any of the three package vignettes.  But generally, using the package is no more difficult that calling:

```r
profplot(x)
```

or

```r
papiplot(x)
```





## Authors

hpcvis is authored and maintained by members of the pbdR core team:
* Drew Schmidt
* Wei-Chen Chen

With additional contributions from:
* Gaurav Sehrawat
