#'
#' Get the Path to arduino-cli
#'
#' For MacOS, this assumes that homebrew was used to install `arduino-cli` and that
#' the path is `/opt/homebrew/bin/arduino-cli`.  NOTE: could add a fall back option
#' using which.
#'
#' @return Character. The path to `arduino-cli`.
#'
#' @author Original code by Chris Suh and Peter Hoff, with modifications by Bryan A. Hanson
#'
#' @export
#'
ud_get_arduino_path <- function() {
  ard_path <- NA_character_
  if (version$os == "linux-gnu") ard_path <- "arduino" # UNTESTED!
  if (grepl("darwin", version$os)) ard_path <- "/opt/homebrew/bin/arduino-cli"
  if (is.na(ard_path)) stop("Could not find arduino-cli binary") # other systems fail
  return(ard_path)
}
