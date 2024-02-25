

![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg) &nbsp; ![Build & Check](https://github.com/bryanhanson/UtiliDuino/workflows/Build-Check/badge.svg) &nbsp; ![Docs Current](https://github.com/bryanhanson/UtiliDuino/workflows/Update-Docs/badge.svg)

![CRAN status](https://www.r-pkg.org/badges/version-last-release/UtiliDuino) &nbsp; ![metacran downloads](https://cranlogs.r-pkg.org/badges/grand-total/UtiliDuino) &nbsp; ![Downloads](https://cranlogs.r-pkg.org/badges/UtiliDuino) &nbsp; ![status](https://tinyverse.netlify.com/badge/UtiliDuino) &nbsp; ![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)

## What is UtiliDuino?

Utilities to Control Arduino Devices! Utility functions to control an `Arduino` microprocessor.  `Arduino` sketches can be compiled and uploaded using `arduino-cli` and the serial port can be used to send messages and receive data. A significant re-imagining of the `Rduino` package. Not affiliated with the [Arduino](https://www.arduino.cc/)

Learn more about [`UtiliDuino`](https://bryanhanson.github.io/UtiliDuino/)

### Installing UtiliDuino from CRAN:

````r
chooseCRANmirror() # choose a CRAN mirror
install.packages("UtiliDuino")
library("UtiliDuino")
````

### Installing UtiliDuino from Github:

````r
install.packages("remotes")
library("remotes")
install_github(repo = "bryanhanson/UtiliDuino@main")
library("UtiliDuino")
````

If you use `@some_other_branch` you can download other branches that might be available.  They may or may not pass CRAN checks and thus may not install automatically using the method above.  Check the NEWS file to see what's up.

### Code of Conduct

This project is released with a [Contributor Code of Conduct](https://bryanhanson.github.io/UtiliDuino/CODE_OF_CONDUCT.html).  By contributing, you agree to abide by its terms.

### Contributing

If you would like to contribute to the project, please see [Contributing Guide](https://bryanhanson.github.io/UtiliDuino/CONTRIBUTING.html).

### License Information

`UtiliDuino` is distributed under the GPL-3 license, as stated in the DESCRIPTION file.  For more info, see the [GPL site.](https://www.gnu.org/licenses/gpl-3.0.html)

Questions?  hanson@depauw.edu
